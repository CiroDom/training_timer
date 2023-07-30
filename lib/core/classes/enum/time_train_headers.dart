enum TimeTrainHeaders {
  series(header: 'Séries:'),
  exec(header: 'Execução:'),
  rest(header: 'Descanso:');

  const TimeTrainHeaders({required this.header});
  
  final header;
}
