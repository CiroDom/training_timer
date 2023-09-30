enum CountdownVoices {
  maleBass(fileName: 'male-bass.mp3',),
  maleNormal(fileName: 'male-normal.mp3',);

  const CountdownVoices({required this.fileName,});

  final String fileName;
}
