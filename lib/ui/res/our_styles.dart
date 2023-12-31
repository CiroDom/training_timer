import 'package:flutter/material.dart';

import 'our_colors.dart';

class OurStyles {
  static const _fontFamily = 'Montserrat';

  static const headerL = TextStyle(
    color: OurColors.textsL,
    fontFamily: _fontFamily,
  );
  static const pickerMainLight = TextStyle(
      color: OurColors.pickerAndButtonsL,
      fontWeight: FontWeight.w400,
      fontSize: 24);
  static const pickerSmallLight = TextStyle(
      color: OurColors.divisorAndShadowNumberL,
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
      color: OurColors.divisorAndShadowNumberD,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      fontFamily: _fontFamily);

  static const visual = TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamily,
  );
}
