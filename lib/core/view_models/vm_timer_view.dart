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
  int _remainingSeconds = 0;
  double _percentageTime = 0;
  bool _rest = false;
  bool _over = false;
  bool _countdown = true;
  bool _initiated = false;
  bool _paused = false;
  bool _canceled = false;

  set _setCurrentSerie(int currentSerie) {
    _currentSerie = currentSerie;
    notifyListeners();
  }

  String get getVisual => _visual;
  int get getTotalSeries => _model.seriesNumber;
  int get getcurrentSerie => _currentSerie;
  double get getPercentageTime => _percentageTime;
  bool get getRest => _rest;
  bool get getOver => _over;
  bool get getCountdown => _countdown;
  bool get getInitiated => _initiated;
  bool get getGoingOn => _paused;

  void _playSound(String soundName) {
    final assetPath = soundName;
    final assetSource = AssetSource(assetPath);
    final audioPlayer = AudioPlayer();

    audioPlayer.play(assetSource);
  }

  void _toogleRest() {
    _rest = !_rest;
    notifyListeners();
  }

  void _tooglePaused() {
    _paused = !_paused;
    notifyListeners();
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

  Future<void> _changeVisual(Duration execOrRestDuration) async {
    int totalSeconds = execOrRestDuration.inSeconds;
    _toogleRest();

    for (int currentSeconds = totalSeconds;
        currentSeconds > 0;
        currentSeconds--) {
      if (_canceled) break;

      _putInRightUnities(currentSeconds);

      _minsToString(_minutes);
      _secsToString(_seconds);

      _visual = '$_stringMin:$_stringSec';
      if (currentSeconds <= 5) {
        _playSound('countdown.wav');
      }
      _percentageTime = currentSeconds / totalSeconds;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<void> _showExecVisual() async {
    await _changeVisual(_model.executionDuration);
  }

  Future<void> _showRestVisual() async {
    await _changeVisual(_model.restDuration);
  }

  Future<void> _initialTimer() async {
    _initiated = true;
    _canceled = false;
    _rest = true;
    for (int countdown = 5; countdown > 0; countdown--) {
      _visual = countdown.toString();
      _playSound('countdown.wav');
      notifyListeners();
      if (_canceled) break;

      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<void> _initiateTraining() async {
    _countdown = false;
    for (int serie = 1; serie <= _model.seriesNumber; serie++) {
      if (_canceled) break;
      _setCurrentSerie = serie;
      _playSound('ding_effect.wav');
      await _showExecVisual();
      _playSound('ding_effect.wav');
      if (serie == _model.seriesNumber) break;
      await _showRestVisual();
    }
  }

  void _executeFinalChanges() {
    _visual = 'FIM';
    _over = true;
    _toogleRest();
    notifyListeners();
  }

  void start() async {
    await _initialTimer();
    await _initiateTraining();
    _executeFinalChanges();
  }

  void playOrPause() async {
    _tooglePaused();
  }

  void stopTimer() {
    _canceled = true;
  }
}
