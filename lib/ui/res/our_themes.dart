import 'package:flutter/material.dart';
import 'package:training_timer/ui/res/our_colors.dart';

class OurThemes {
  static final light = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: OurColors.backgroundLight,
      appBarTheme: const AppBarTheme(backgroundColor: OurColors.pickerLight),
      textTheme: const TextTheme(
          bodyMedium: TextStyle(
              color: OurColors.textsLight,)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => OurColors.pickerLight),
              foregroundColor: MaterialStateColor.resolveWith(
                  (states) => OurColors.backgroundLight))));

  static final dark = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: OurColors.backgroundDark,
      appBarTheme:
          const AppBarTheme(backgroundColor: OurColors.backgroundBarDark),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: OurColors.pickerDark,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => OurColors.pickerDark),
              foregroundColor: MaterialStateColor.resolveWith(
                  (states) => OurColors.textsDark))));
}
