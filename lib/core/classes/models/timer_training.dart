class TimerTraining {
  final int seriesNumber;
  final int countdown;
  final Duration executionDuration;
  final Duration restDuration;

  const TimerTraining(
      {int howManyCountdown = 5,
      required this.seriesNumber,
      required this.executionDuration,
      required this.restDuration})
      : countdown = howManyCountdown;
}
