import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'material_app/workout_timers_app.dart';
import 'ui/provider_models/theme_model.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (context) => ThemeModel(), child: const WorkoutTimersApp()));
