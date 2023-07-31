import 'package:flutter/material.dart';
import 'package:training_timer/ui/res/our_colors.dart';

class OurStyles {
  static const _fontFamily = 'Nunito';

  static const headerL = TextStyle(
    color: OurColors.textsL,
    fontFamily: _fontFamily,
  );
  static const pickerMainLight = TextStyle(
      color: OurColors.pickerAndButtonsL,
      fontWeight: FontWeight.w400,
      fontSize: 24);
  static const pickerSmallLight = TextStyle(
      color: OurColors.secondBackgroundL,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      fontFamily: _fontFamily);

  static const headerD = TextStyle(
    color: OurColors.textsL,
    fontFamily: _fontFamily,
  );
  static const pickerMainDark = TextStyle(
      color: OurColors.pickerAndButtonsD,
      fontWeight: FontWeight.w400,
      fontSize: 24);
  static const pickerSmallDark = TextStyle(
      color: OurColors.secondBackgroundD,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      fontFamily: _fontFamily);

  static const visual = TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamily,
  );
}
