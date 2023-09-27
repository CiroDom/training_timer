import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:training_timer/core/view_models/interfaces/time_view_vm.dart';

import '../../../models/time_training.dart';

class VmTimerTime extends ChangeNotifier implements VmTime {
  TimerTraining _model;

  VmTimerTime({required TimerTraining model}) : _model = model;

  String _timerMsg = 'Vamos?';
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

  void _goTimer(int durationInSecs) async {
    int currentSeconds = durationInSecs;
    Timer.periodic(Duration(seconds: 1), (timer) {
      _putInRightUnities(currentSeconds);
      print(currentSeconds);

      currentSeconds--;
      notifyListeners();
      if (currentSeconds <= 5) _playSound(countdownSoundPath);
      if (_canceledTimer || currentSeconds <= 0) timer.cancel();
    });
  }

  Future<void> _initialTimer() async {
    // _initiated = true;
    // _canceledTimer = false;
    // _rest = true;
    int countdown = 5;
    _goTimer(countdown);
    // _initiateTraining();
  }

  Future<void> _initiateTraining() async {
    final anyTime = 30;
    _goTimer(anyTime);
  }

  void start() {
    _initialTimer();
  }

  void pause() async {
    _paused = true;
    _canceledTimer = true;

    notifyListeners();
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
