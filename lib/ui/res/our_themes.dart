import 'package:flutter/material.dart';
import 'package:training_timer/ui/res/our_colors.dart';

class OurThemes {
  static final light = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: OurColors.backgroundL,
      appBarTheme: const AppBarTheme(backgroundColor: OurColors.pickerL),
      textTheme: const TextTheme(
          bodyMedium: TextStyle(
        color: OurColors.textsL,
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => OurColors.pickerL),
              foregroundColor: MaterialStateColor.resolveWith(
                  (states) => OurColors.backgroundL))));

  static final dark = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: OurColors.backgroundD,
      appBarTheme:
          const AppBarTheme(backgroundColor: OurColors.secondBackgroundD),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: OurColors.pickerD,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => OurColors.pickerD),
              foregroundColor: MaterialStateColor.resolveWith(
                  (states) => OurColors.textsD))));
}
