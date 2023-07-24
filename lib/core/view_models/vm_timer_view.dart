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
  bool _rest = false;
  bool _over = false;

  set _setCurrentSerie(int currentSerie) {
    _currentSerie = currentSerie;
    notifyListeners();
  }

  String get getVisual => _visual;
  int get getSeries => _currentSerie;
  bool get getRest => _rest;
  bool get getOver => _over;

  void _playSound(String assetPath) {
    final audioPlayer = AudioPlayer();
    final assetSource = AssetSource(assetPath);

    audioPlayer.play(assetSource);
  }

  void _toogleRest() {
    _rest = !_rest;
    print(_rest);
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

    for (int i = totalSeconds; i >= 0; i--) {
      _putInRightUnities(i);

      _hoursToString(_hours);
      _minsToString(_minutes);
      _secsToString(_seconds);

      _visual = '$_stringHour:$_stringMin:$_stringSec';
      notifyListeners();
      print(_visual);

      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<void> _showExecVisual() async {
    await _changeVisual(_model.executionDuration);
    print('Exec');
  }

  Future<void> _showRestVisual() async {
    await _changeVisual(_model.restDuration);
    print('Rest');
  }

  Future<void> _initialTimer() async {
    int countdown = 5;

    for (int i = 5; i >= 0; i--) {
      _visual = countdown.toString();
      notifyListeners();

      await Future.delayed(const Duration(seconds: 1));
      countdown--;
    }
  }
  
  Future<void> _initiateTraining() async {
    for (int i = 1; i <= _model.seriesNumber; i++) {
      _setCurrentSerie = i;
      await _showExecVisual();
      await _showRestVisual();
    }
  }

  void _executeFinalChanges() {
    _visual = 'Acabou';
    _over = true;
    notifyListeners();
    print('Acabou');
  }

  void start() async {
    await _initialTimer();
    await _initiateTraining();
    _executeFinalChanges();
  }

  void backToInitialView(BuildContext context) {
    Navigator.of(context).pop();
  }
}
