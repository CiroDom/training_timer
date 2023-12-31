import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/view_models/training_vms/timer_training_vms/vm_timer_edit_view.dart';
import '../ui/provider_models/theme_model.dart';
import '../ui/res/our_themes.dart';
import '../ui/views/training_views/timer_views/timer_edit_view.dart';

class WorkoutTimersApp extends StatelessWidget {
  const WorkoutTimersApp({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = VmTimerEditView();
    ThemeMode ourThemeMode =
        Provider.of<ThemeModel>(context, listen: true).getOurThemeMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ourThemeMode,
      theme: OurThemes.light,
      darkTheme: OurThemes.dark,
      home: TimerEditView(viewModel: presenter),
      title: 'Workout Timers',
    );
  }
}
