class TimerTraining {
  final int seriesNumber;
  final int countdownTimer;
  final Duration executionDuration;
  final Duration restDuration;
  final String voiceFileName;
  final String alarmFileName;

  const TimerTraining({
    required this.countdownTimer,
    required this.seriesNumber,
    required this.executionDuration,
    required this.restDuration,
    required this.voiceFileName,
    required this.alarmFileName,
  });
}
