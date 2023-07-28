import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_timer/material_app/training_timer_app.dart';
import 'package:training_timer/ui/provider_models/theme_model.dart';

void main() => runApp(ChangeNotifierProvider(
  create: (context) => ThemeModel(),
  child: const TrainingTimerApp()));

