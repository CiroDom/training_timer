import 'package:flutter/material.dart';
import 'package:training_timer/ui/res/our_colors.dart';

class OurThemes {
  static final light = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: OurColors.backgroundL,
      appBarTheme: const AppBarTheme(backgroundColor: OurColors.pickerAndButtonsL),
      textTheme: const TextTheme(
          bodyMedium: TextStyle(
        color: OurColors.textsL,
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: OurColors.pickerAndButtonsL
        )
      )
  );

  static final dark = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: OurColors.backgroundD,
      appBarTheme:
          const AppBarTheme(backgroundColor: OurColors.secondBackgroundD),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: OurColors.pickerAndButtonsD,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: OurColors.pickerAndButtonsD
        )
      )
  );
}
