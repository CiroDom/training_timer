import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:training_timer/core/classes/models/time_training.dart';

class VmTimerView extends ChangeNotifier {
  final TimeTraining _model;

  VmTimerView({required TimeTraining model}) : _model = model;

  String _visual = 'Vamos?';
  String _stringMin = 'MM';
  String _stringSec = 'SS';
  int _currentSerie = 0;
  int _minutes = 0;
  int _seconds = 0;
  double _percentageTime = 0;
  bool _rest = false;
  bool _over = false;
  bool _countdown = true;
  bool _initiated = false;
  bool _paused = false;
  bool _canceledTimer = false;

  final dingSoundPath = 'ding_effect.wav';
  final countdownSoundPath = 'countdown.wav';

  String get getVisual => _visual;
  int get getTotalSeries => _model.seriesNumber;
  int get getcurrentSerie => _currentSerie;
  double get getPercentageTime => _percentageTime;
  bool get getRest => _rest;
  bool get getOver => _over;
  bool get getCountdown => _countdown;
  bool get getInitiated => _initiated;
  bool get getPaused => _paused;

  void _playSound(String soundName) {
    final assetPath = soundName;
    final assetSource = AssetSource(assetPath);
    final audioPlayer = AudioPlayer();

    audioPlayer.play(assetSource);
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

  void _minsToString(int numberMin) {
    if (numberMin < 10) {
      _stringMin = '0$numberMin';
    } else {
      _stringMin = '$numberMin';
    }
  }

  void _secsToString(int numberSec) {
    if (numberSec < 10) {
      _stringSec = '0$numberSec';
    } else {
      _stringSec = '$numberSec';
    }
  }

  Future<void> _changeVisual(Duration duration) async {
    final totalSeconds = duration.inSeconds;
    final execDur = _model.executionDuration.inSeconds;
    final restDur = _model.restDuration.inSeconds;
    final restOrExecTotalSecs = _rest ? restDur : execDur;

    for (int currentSeconds = totalSeconds;
        currentSeconds > 0;
        currentSeconds--) {
      if (_canceledTimer) break;

      _putInRightUnities(currentSeconds);

      _minsToString(_minutes);
      _secsToString(_seconds);

      _visual = '$_stringMin:$_stringSec';
      if (currentSeconds <= 5) {
        _playSound(countdownSoundPath);
      }
      _percentageTime = currentSeconds / restOrExecTotalSecs;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<void> _showExecVisual() async {
    _rest = false;
    await _changeVisual(_model.executionDuration);
    if (!_canceledTimer) {
      _rest = true;
      notifyListeners();
    }
  }

  Future<void> _showRestVisual() async {
    _rest = true;
    await _changeVisual(_model.restDuration);
    if (!_canceledTimer) {
      _rest = false;
      notifyListeners();
    }
  }

  Future<void> _initialTimer() async {
    _initiated = true;
    _canceledTimer = false;
    _rest = true;
    for (int countdown = 5; countdown > 0; countdown--) {
      _visual = countdown.toString();
      _playSound(countdownSoundPath);
      notifyListeners();
      if (_canceledTimer) break;

      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<void> _initiateTraining() async {
    _countdown = false;
    for (int serie = 1; serie <= _model.seriesNumber; serie++) {
      if (_canceledTimer) break;
      _currentSerie = serie;
      if (!_canceledTimer) _playSound(dingSoundPath);
      await _showExecVisual();
      if (!_canceledTimer) _playSound(dingSoundPath);
      if (serie == _model.seriesNumber) break;
      await _showRestVisual();
    }
  }

  void _executeFinalChanges() {
    _visual = 'FIM';
    _percentageTime = 0;
    _over = true;
    _rest = true;
    notifyListeners();
  }

  void start() async {
    await _initialTimer();
    await _initiateTraining();
    if (_paused && _canceledTimer) return;
    _executeFinalChanges();
  }

  void pause() async {
    _paused = true;
    _canceledTimer = true;

    notifyListeners();
  }

  Future<void> continueTraining() async {
    _paused = false;
    _canceledTimer = false;

    final remainingDuration = Duration(minutes: _minutes, seconds: _seconds);
    await _changeVisual(remainingDuration);

    if (!_rest && _currentSerie == _model.seriesNumber) {
      _executeFinalChanges();
      return;
    }

    for (int serie = _currentSerie; serie <= _model.seriesNumber; serie++) {
      if (_canceledTimer) break;
      _currentSerie = serie;
      _playSound(dingSoundPath);
      await _showExecVisual();
      _playSound(dingSoundPath);
      if (serie == _model.seriesNumber) break;
      await _showRestVisual();
    }
    _executeFinalChanges();
  }

  void totalCancel() {
    _paused = false;
    _canceledTimer = true;
    notifyListeners();
  }

  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
