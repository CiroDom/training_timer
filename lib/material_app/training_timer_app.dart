import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/view_models/training_vms/timer_training_vms/vm_edit_timer.dart';
import '../ui/provider_models/theme_model.dart';
import '../ui/res/our_themes.dart';
import '../ui/views/training_views/timer_train_view.dart';

class TrainingTimerApp extends StatelessWidget {
  const TrainingTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = VmEditTimer();
    ThemeMode ourThemeMode =
        Provider.of<ThemeModel>(context, listen: true).getOurThemeMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ourThemeMode,
      theme: OurThemes.light,
      darkTheme: OurThemes.dark,
      home: TimerTrainView(viewModel: presenter),
    );
  }
}
