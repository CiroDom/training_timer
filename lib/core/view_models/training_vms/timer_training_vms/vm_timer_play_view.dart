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
  Completer<bool> _completer = Completer();

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

    int audioBegin = countdownBegin;
    for (int i = 0; i <= 7; i++) {
      if (i + countdownBegin == 10) {
        audioBegin = i;
        break;
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

  void _goTimer(
      int durationInSecs, int countdownBegin, Completer completer) async {
    int currentSeconds = durationInSecs;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentSeconds == countdownBegin) {
        _playSound(true, _model.voiceFileName, countdownBegin);
      }

      if (_canceledTimer) {
        _audioPlayer.stop();
        timer.cancel();
      }
      if (currentSeconds <= 0) {
        timer.cancel();
      }

      _putInRightUnities(currentSeconds);

      currentSeconds--;
      notifyListeners();
    });
  }

  Future<void> _initialTimer() async {
    _initiated = true;
    _rest = true;
    int countdown = _model.countdownTimer;
    _goTimer(countdown, countdown, _completer);
    // _initiateTraining();
  }

  Future<void> _initiateTraining() async {
    final anyTime = 30;
    _goTimer(anyTime, 5, _completer);
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
    _audioPlayer.stop;
    notifyListeners();
  }

  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
