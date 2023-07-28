import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:training_timer/core/classes/models/time_training.dart';

class VmTimerView extends ChangeNotifier {
  final TimeTraining _model;

  VmTimerView({required TimeTraining model}) : _model = model;

  String _visual = 'visual';
  String _stringHour = 'HH';
  String _stringMin = 'MM';
  String _stringSec = 'SS';
  int _currentSerie = 0;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  double _percentageTime = 0;
  bool _rest = false;
  bool _over = false;
  bool _timeTraining = true;
  bool _trainingCountdown = true;

  set _setCurrentSerie(int currentSerie) {
    _currentSerie = currentSerie;
    notifyListeners();
  }

  String get getVisual => _visual;
  int get getSeries => _currentSerie;
  double get getPercentageTime => _percentageTime;
  bool get getRest => _rest;
  bool get getOver => _over;

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

  void _putInRightUnities(int seconds) {
    if (seconds >= 3600) {
      _hours = seconds ~/ 3600;
    }

    if (_hours > 0) {
      _minutes = (seconds % 3600) ~/ 60;
    } else if (seconds >= 60) {
      _minutes = seconds ~/ 60;
    } else if (seconds < 60) {
      _minutes = 0;
    }

    if (seconds >= 60) {
      _seconds = (seconds % 60);
    } else {
      _seconds = seconds;
    }
  }

  void _hoursToString(int numberHour) {
    if (numberHour < 10) {
      _stringHour = '0$numberHour';
    } else {
      _stringHour = '$numberHour';
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
      _putInRightUnities(currentSeconds);

      _hoursToString(_hours);
      _minsToString(_minutes);
      _secsToString(_seconds);

      _visual = '$_stringHour:$_stringMin:$_stringSec';
      if (_timeTraining && _trainingCountdown && currentSeconds <= 5) {
        _playSound('countdown.wav');
      }
      _percentageTime = currentSeconds / totalSeconds;
      notifyListeners();
      print(_visual);

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
    for (int countdown = 5; countdown > 0; countdown--) {
      _visual = countdown.toString();
      _playSound('countdown.wav');
      notifyListeners();

      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<void> _initiateTraining() async {
    for (int serie = 1; serie <= _model.seriesNumber; serie++) {
      _setCurrentSerie = serie;
      _playSound('ding_effect.wav');
      await _showExecVisual();
      _playSound('ding_effect.wav');
      if (serie == _model.seriesNumber) {
        break;
      }
      await _showRestVisual();
    }
  }

  void _executeFinalChanges() {
    _visual = 'Acabou';
    _over = true;
    notifyListeners();
  }

  void start() async {
    await _initialTimer();
    await _initiateTraining();
    _executeFinalChanges();
  }
}
