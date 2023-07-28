import 'package:flutter/material.dart';
import 'package:training_timer/ui/res/our_colors.dart';

class OurThemes {
  static final light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: OurColors.backgroundLight,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: OurColors.textAndDetLight,
      ),
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: OurColors.backgroundDark,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: OurColors.backgroundDark,
      ),
    ),
  );
}
