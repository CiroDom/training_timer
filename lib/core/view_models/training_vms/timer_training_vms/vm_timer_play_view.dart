import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:training_timer/core/enums/countdown_alarms.dart';
import 'package:training_timer/core/view_models/interfaces/time_view_vm.dart';

import '../../../models/time_training.dart';

class VmTimerTimeView extends ChangeNotifier implements VmTime {
  final TimerTraining _model;

  VmTimerTimeView({required TimerTraining model}) : _model = model;

  // NON-FINAL PROPRIETIES
  String _timerMsg = 'Vamos?';
  int _currentSerie = 0;
  int _minutes = 0;
  int _seconds = 0;
  double _percentageTime = 0;
  bool _rest = true;
  bool _over = false;
  bool _initiated = false;
  bool _training = false;
  bool _paused = false;
  bool _canceledTimer = false;
  bool _wasResting = false;

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
  double get getPercentageTime => _percentageTime;
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
      for (int i = 0; i <= 7; i++) {
        if (i + countdownBegin == 10) {
          audioBegin = i;
          break;
        }
      }
    }

    _audioPlayer.play(assetSource, position: Duration(seconds: audioBegin));
  }

  void _putInRightUnities(int seconds) {
    if (seconds >= 60) {
      _minutes = seconds ~/ 60;
      _seconds = (seconds % 60);
    } else {
      _minutes = 0;
      _seconds = seconds;
    }
  }

  Future<void> _goTimer(int durationsInSecs, int countdownBegin) async {
    final completer = Completer();

    int currentSecs = durationsInSecs;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      final goCountdown = currentSecs == countdownBegin;

      if (goCountdown) {
        _playSound(true, _model.voiceFileName, countdownBegin);
      }

      if (_canceledTimer) {
        _audioPlayer.stop();
        timer.cancel();
      }

      if (currentSecs <= 0) {
        completer.complete();
        timer.cancel();
      }

      _putInRightUnities(currentSecs);

      currentSecs = currentSecs - 1;
      notifyListeners();
    });

    await completer.future;
  }

  void _executeFinalChanges() {
    _timerMsg = 'FIM!';
    _over = true;
    _rest = true;
    _percentageTime = 0.0;

    _playSound(
      false,
      _model.alarmFileName,
      0,
    );
  }

  Future<void> _initialTimer() async {
    _training = false;
    _initiated = true;
    int countdown = _model.countdownTimer;
    await _goTimer(
      countdown,
      countdown,
    );
  }

  Future<void> _workout(int initialSerie, int finalSerie) async {
    for (int i = initialSerie; i <= finalSerie; i++) {
      _currentSerie = i;

      _rest = false;
      await _goTimer(_model.executionDuration.inSeconds, _model.countdownTimer);

      _rest = true;
      if (_currentSerie == _model.seriesNumber) break;
      await _goTimer(_model.restDuration.inSeconds, _model.countdownTimer);
    }
  }

  int createRemainingDur() {
    final remainingDur = Duration(minutes: _minutes, seconds: _seconds);
    final remainDurInSecs = remainingDur.inSeconds;

    return remainDurInSecs;
  }

  Future<void> _ifItWasResting(bool wasResting, int remaingDurSecs,
      int restDurSecs, int countdownTimer) async {
    if (wasResting) {
      if (remaingDurSecs < countdownTimer) {
        await _goTimer(remaingDurSecs, remaingDurSecs);
      } else {
        await _goTimer(remaingDurSecs, countdownTimer);
      }
    } else {
      _rest = false;

      if (remaingDurSecs < _model.countdownTimer) {
        await _goTimer(remaingDurSecs, remaingDurSecs);
        _rest = true;
        await _goTimer(remaingDurSecs, countdownTimer);
      } else {
        await _goTimer(remaingDurSecs, countdownTimer);
        _rest = true;
        await _goTimer(remaingDurSecs, countdownTimer);
      }
    }
  }

  Future<void> _playBrokenSerie() async {
    final remainDurInSecs = createRemainingDur();
    final restDurInSecs = _model.restDuration.inSeconds;
    final countdownTimer = _model.countdownTimer;
    _canceledTimer = false;

    _ifItWasResting(
        _wasResting, remainDurInSecs, restDurInSecs, countdownTimer);

    _currentSerie++;
  }

  void start() async {
    await _initialTimer();

    await _workout(1, _model.seriesNumber);

    _executeFinalChanges();
  }

  void startAgain() async {
    await _playBrokenSerie();

    await _workout(_currentSerie, _model.seriesNumber);

    _executeFinalChanges();
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
