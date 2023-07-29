import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:training_timer/ui/views/our_styles.dart';

class OurNumberPicker extends StatelessWidget {
  const OurNumberPicker({
    super.key,
    required this.seriesConter,
    required this.value,
    required this.maxValue,
    required this.onChanged,
    required this.darkMode,
  });

  final bool seriesConter;
  final int value;
  final int maxValue;
  final void Function(int) onChanged;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberPicker(
        selectedTextStyle: darkMode
            ? OurStyles.pickerMainDark
            : OurStyles.pickerMainLight,
        textStyle: darkMode
            ? OurStyles.pickerSmallDark
            : OurStyles.pickerSmallLight,
        axis: Axis.vertical,
        itemWidth: 60,
        itemHeight: 35,
        itemCount: 3,
        value: value,
        minValue: seriesConter ? 1 : 0,
        maxValue: maxValue,
        onChanged: onChanged,
      ),
    );
  }
}
