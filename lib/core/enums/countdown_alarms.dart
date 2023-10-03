enum CountdownAlarms {
  alarm(
    fileName: 'alarm.mp3',
    title: 'Alarme'),
  beep(
    fileName: 'beep.mp3',
    title: 'Beep');

  const CountdownAlarms({
    required this.fileName,
    required this.title
  });

  final String fileName;
  final String title;
}
