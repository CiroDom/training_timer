enum TimeTrainPickerInfos {
  series(minValue: 1, maxValue: 99, unity: 'series'),
  hour(minValue: 0, maxValue: 23, unity: 'hours'),
  min(minValue: 0, maxValue: 59, unity: 'mins'),
  sec(minValue: 0, maxValue: 59, unity: 'secs');

  const TimeTrainPickerInfos(
      {required this.minValue, required this.maxValue, required this.unity});

  final int minValue;
  final int maxValue;
  final String unity;
}
