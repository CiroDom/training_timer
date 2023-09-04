import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_timer/core/presenters/pres_initial_view.dart';
import 'package:training_timer/ui/provider_models/theme_model.dart';
import 'package:training_timer/ui/res/our_themes.dart';

import '../ui/views/complete_views/initial_view.dart';

class TrainingTimerApp extends StatelessWidget {
  const TrainingTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = PresInitialView();
    ThemeMode ourThemeMode =
        Provider.of<ThemeModel>(context, listen: true).getOurThemeMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ourThemeMode,
      theme: OurThemes.light,
      darkTheme: OurThemes.dark,
      home: InitialView(presenter: presenter),
    );
  }
}
