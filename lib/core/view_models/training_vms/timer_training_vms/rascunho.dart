// Timer.periodic(const Duration(milliseconds: 100), (timer) {
//       final goCountdown = _currentMilli / 1000 == countdownBegin;

//       if (goCountdown) {
//         _playSound(true, _model.voiceFileName, countdownBegin);
//       }

//       if (_canceledTimer) {
//         _audioPlayer.stop();
//         timer.cancel();
//       }

//       if (_currentMilli < 0 && _currentMilli > -900) {
//         completer.complete();
//         timer.cancel();
//       }

//       _putInRightUnities(_currentMilli);
//       _putInPercentual(_currentMilli, duration.inMilliseconds);

//       _currentMilli = _currentMilli - 100;

//       notifyListeners();
//     });