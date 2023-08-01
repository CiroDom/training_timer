import 'package:flutter/material.dart';
import 'package:training_timer/ui/res/our_colors.dart';

class OurThemes {
  static final light = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: OurColors.backgroundL,
      appBarTheme:
          const AppBarTheme(backgroundColor: OurColors.pickerAndButtonsL),
      textTheme: const TextTheme(
          bodyMedium: TextStyle(
        color: OurColors.textsL,
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              backgroundColor: OurColors.pickerAndButtonsL)));

  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: OurColors.backgroundD,
    appBarTheme:
        const AppBarTheme(backgroundColor: OurColors.divisorAndShadowNumberD),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: OurColors.pickerAndButtonsD,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            elevation: 2.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            backgroundColor: OurColors.pickerAndButtonsD)),
  );
}
