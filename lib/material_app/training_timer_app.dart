import 'package:flutter/material.dart';
import 'package:training_timer/core/view_models/vm_initial_view.dart';

import '../ui/views/initial_view.dart';

class TrainingTimerApp extends StatelessWidget {
  const TrainingTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final viemModel = VmInitialView();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InitialView(viewModel: viemModel),
    );
  }
}
