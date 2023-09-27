class RepTraining {
  const RepTraining( 
      {int howManyCountdown = 5,
      required this.seriesNumber,
      required this.restDuration,
      required this.extraRest})
      : countdown = howManyCountdown;

  final int seriesNumber;
  final int countdown;
  final Duration restDuration;
  final Duration extraRest;
}
