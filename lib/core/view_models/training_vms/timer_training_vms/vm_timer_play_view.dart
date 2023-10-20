import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  int _currentMilli = 0;
  int _currentTotalDur = 0;
  double _percentual = 0;
  bool _rest = true;
  bool _over = false;
  bool _initiated = false;
  bool _training = false;
  bool _paused = false;
  bool _canceledTimer = false;
  bool _brokenSerie = false;
  Ticker? _ticker;

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
  int get getSecCountdown => _seconds;
  int get getTotalSeries => _model.seriesNumber;
  int get getcurrentSerie => _currentSerie;
  double get getPercentageTime => _percentual;
  bool get getRest => _rest;
  bool get getOver => _over;
  bool get getInitiated => _initiated;
  bool get getTraining => _training;
  bool get getPaused => _paused;

  // OTHER METHODS
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

    _currentMilli = duration.inMilliseconds;

    _putInRightUnities(_currentMilli);
    _putInPercentual(_currentMilli, duration.inMilliseconds);

    if (training) {
      rest ? _rest = true : _rest = false;
    }

    _ticker = Ticker((elapsed) {
      _currentMilli = duration.inMilliseconds - elapsed.inMilliseconds;

      _putInRightUnities(_currentMilli);
      _putInPercentual(_currentMilli, duration.inMilliseconds);

      notifyListeners();

      if ((duration - elapsed).inSeconds == countdownBegin) {
        _playSound(true, _model.voiceFileName, countdownBegin);
      }

      if (_canceledTimer) {
        _audioPlayer.stop();
        _ticker?.dispose();
      }

      if (elapsed.inSeconds == duration.inSeconds) {
        completer.complete();
        _ticker?.dispose();
      }
    });

    _ticker?.start();

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
    final remainingDur = Duration(milliseconds: _currentMilli);

    return remainingDur;
  }

  Future<void> _restingIfAndElse(bool resting, Duration remaingDur,
      Duration restDur, int countdownTimer) async {
    final lastSerie = _currentSerie == _model.seriesNumber;
    final lessThanCount = (remaingDur.inSeconds < _model.countdownTimer);

    if (resting) {
      _brokenSerie = true;

      if (lessThanCount) {
        for (int i = 1; i == 1; i--) {
          await _goTimer(
            remaingDur,
            remaingDur.inSeconds,
            true,
            true,
          );
          if (_canceledTimer) break;
        }
      } else {
        for (int i = 1; i == 1; i--) {
          await _goTimer(
            remaingDur,
            countdownTimer,
            true,
            true,
          );
          if (_canceledTimer) break;
        }
      }

      _brokenSerie = false;
    } else {
      if (lessThanCount) {
        for (int i = 1; i == 1; i--) {
          _brokenSerie = true;

          await _goTimer(
            remaingDur,
            remaingDur.inSeconds,
            true,
            false,
          );
          _brokenSerie = false;
          if (_canceledTimer) break;
          if (lastSerie) break;
          await _goTimer(
            restDur,
            countdownTimer,
            true,
            true,
          );
          if (_canceledTimer) break;
        }
      } else {
        for (int i = 1; i == 1; i--) {
          _brokenSerie = true;

          await _goTimer(
            remaingDur,
            countdownTimer,
            true,
            false,
          );
          _brokenSerie = false;
          if (_canceledTimer) break;
          if (lastSerie) break;
          await _goTimer(
            restDur,
            countdownTimer,
            true,
            true,
          );
          if (_canceledTimer) break;
        }
      }
    }
  }

  Future<void> _playBrokenSerie() async {
    final remainDur = _createRemainingDur();
    final restDur = _model.restDuration;
    final countdownTimer = _model.countdownTimer;
    _paused = false;
    _canceledTimer = false;
    _brokenSerie = true;

    await _restingIfAndElse(_rest, remainDur, restDur, countdownTimer);
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
      _currentSerie++;
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
    _ticker?.dispose;
    notifyListeners();
  }

  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
