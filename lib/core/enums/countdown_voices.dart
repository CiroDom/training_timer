enum CountdownVoices {
  bass(
    fileName: 'bass.mp3',
    title: 'Grave'),
  nasal(
    fileName: 'nasal.mp3',
    title: 'Nasal'),
  ressoing(
    fileName: 'ressoing.mp3',
    title: 'Ressoante'),
  robot(
    fileName: 'robot.mp3',
    title: 'Robótica');

  const CountdownVoices({
    required this.fileName,
    required this.title
  });

  final String fileName;
  final String title;
}
