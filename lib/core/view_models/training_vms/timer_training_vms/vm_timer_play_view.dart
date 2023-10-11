import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:workout_timers/core/view_models/interfaces/time_view_vm.dart';

import '../../../models/time_training.dart';

class VmTimerTimeView extends ChangeNotifier implements VmTime {
  final TimerTraining _model;

  VmTimerTimeView({required TimerTraining model}) : _model = model;

  // NON-FINAL PROPRIETIES
  String _timerMsg = 'Vamos?';
  int _currentSerie = 0;
  int _minutes = 0;
  int _seconds = 0;
  int _currentTotalDur = 0;
  double _percentual = 0;
  bool _rest = true;
  bool _over = false;
  bool _initiated = false;
  bool _training = false;
  bool _paused = false;
  bool _canceledTimer = false;
  bool _brokenSerie = false;

  // FINAL PROPRIETIES
  final _audioPlayer = AudioPlayer();

  // GETTERS
  String get getStringSec {
    if (_seconds < 10) {
      return '0$_seconds';
    } else {
      return '$_seconds';
    }
  }

  String get getStringMin {
    if (_minutes < 10) {
      return '0$_minutes';
    } else {
      return '$_minutes';
    }
  }

  String get getTimerMsg => _timerMsg;
  int get getTotalSeries => _model.seriesNumber;
  int get getcurrentSerie => _currentSerie;
  double get getPercentageTime => _percentual;
  bool get getRest => _rest;
  bool get getOver => _over;
  bool get getInitiated => _initiated;
  bool get getTraining => _training;
  bool get getPaused => _paused;

  // METHODS
  void _playSound(bool isVoice, String soundName, int countdownBegin) {
    final assetPath =
        isVoice ? 'countdown-voices/$soundName' : 'alarm/$soundName';
    final assetSource = AssetSource(assetPath);
    int audioBegin = 0;

    if (isVoice) {
      audioBegin = countdownBegin;
      for (int i = 0; i <= 10; i++) {
        if (i + countdownBegin == 10) {
          audioBegin = i;
          break;
        }
      }
    }

    _audioPlayer.play(assetSource, position: Duration(seconds: audioBegin));
  }

  int _fromMilliToSec(int milli) {
    if (milli / 1000 == Duration(milliseconds: milli).inSeconds) {
      final exactSec = Duration(milliseconds: milli).inSeconds;

      return exactSec;
    } else {
      final roundedUpSec = (Duration(milliseconds: milli).inSeconds + 1);

      return roundedUpSec;
    }
  }

  void _putInRightUnities(int milli) {
    int seconds = _fromMilliToSec(milli);

    if (seconds >= 60) {
      _minutes = seconds ~/ 60;
      _seconds = (seconds % 60);
    } else {
      _minutes = 0;
      _seconds = seconds;
    }
  }

  void _putInPercentual(int somePercentual, int newTotal) {
    if (_brokenSerie) {
      _percentual = somePercentual / _currentTotalDur;
    } else {
      _currentTotalDur = newTotal;

      _percentual = somePercentual / newTotal;
    }
  }

  Future<void> _goTimer(
      Duration duration, int countdownBegin, bool training, bool rest) async {
    final completer = Completer();

    int currentMilli = duration.inMilliseconds;

    _putInRightUnities(currentMilli);
    _putInPercentual(currentMilli, duration.inMilliseconds);

    if (training) {
      rest ? _rest = true : _rest = false;
    }

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final goCountdown = currentMilli / 1000 == countdownBegin;

      if (goCountdown) {
        _playSound(true, _model.voiceFileName, countdownBegin);
      }

      if (_canceledTimer) {
        _audioPlayer.stop();
        timer.cancel();
      }

      if (currentMilli < 0 && currentMilli > -900) {
        completer.complete();
        timer.cancel();
      }

      _putInRightUnities(currentMilli);
      _putInPercentual(currentMilli, duration.inMilliseconds);

      currentMilli = currentMilli - 100;

      notifyListeners();
    });
    await completer.future;
  }

  void _executeFinalChanges(bool over) {
    if (over) {
      _timerMsg = 'FIM!';
      _training = false;
      _percentual = 0.0;

      _playSound(
        false,
        _model.alarmFileName,
        0,
      );
    } else
      return;
  }

  Future<void> _initialTimer() async {
    _training = false;
    _initiated = true;
    final countdownDur = Duration(seconds: _model.countdownTimer);
    final countdownBegin = _model.countdownTimer;
    await _goTimer(countdownDur, countdownBegin, false, false);
  }

  Future<void> _workout(int initialSerie, int finalSerie) async {
    _training = true;

    for (int i = initialSerie; i <= finalSerie; i++) {
      _currentSerie = i;

      await _goTimer(
          _model.executionDuration, _model.countdownTimer, true, false);

      if (_currentSerie == _model.seriesNumber) {
        _over = true;
        break;
      }
      await _goTimer(_model.restDuration, _model.countdownTimer, true, true);
    }

    _executeFinalChanges(_over);
  }

  Duration _createRemainingDur() {
    final remainingDur = Duration(minutes: _minutes, seconds: _seconds);

    return remainingDur;
  }

  Future<void> _restingIfAndElse(bool resting, Duration remaingDur,
      Duration restDur, int countdownTimer) async {
    if (resting) {
      if (remaingDur.inSeconds < countdownTimer) {
        await _goTimer(
          remaingDur,
          remaingDur.inSeconds,
          true,
          true,
        );
      } else {
        await _goTimer(
          remaingDur,
          countdownTimer,
          true,
          true,
        );
      }
    } else {
      if (remaingDur.inSeconds < _model.countdownTimer) {
        for (int i = 1; i == 1; i--) {
          await _goTimer(
            remaingDur,
            remaingDur.inSeconds,
            true,
            false,
          );
          if (_canceledTimer) break;
          if (_currentSerie == _model.seriesNumber) break;
          await _goTimer(
            remaingDur,
            countdownTimer,
            true,
            true,
          );
        }
      } else {
        for (int i = 1; i == 1;) {
          await _goTimer(
            remaingDur,
            countdownTimer,
            true,
            false,
          );
          if (_canceledTimer) break;
          if (_currentSerie == _model.seriesNumber) break;
          await _goTimer(
            remaingDur,
            countdownTimer,
            true,
            true,
          );
        }
      }
    }
  }

  Future<void> _playBrokenSerie() async {
    final remainDurInSecs = _createRemainingDur();
    final restDur = _model.restDuration;
    final countdownTimer = _model.countdownTimer;
    _paused = false;
    _canceledTimer = false;
    _brokenSerie = true;

    await _restingIfAndElse(_rest, remainDurInSecs, restDur, countdownTimer);

    _brokenSerie = false;
  }

  void start() async {
    await _initialTimer();

    await _workout(1, _model.seriesNumber);
  }

  void startAgain() async {
    await _playBrokenSerie();

    if (_currentSerie == _model.seriesNumber) {
      _over = true;
      _executeFinalChanges(_over);
    } else {
      await _workout(_currentSerie, _model.seriesNumber);
    }
  }

  void pause() async {
    _paused = true;
    _canceledTimer = true;

    notifyListeners();
  }

  void totalCancel() {
    _paused = false;
    _canceledTimer = true;
    _audioPlayer.stop;
    notifyListeners();
  }

  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
