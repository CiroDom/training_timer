import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class OurNumberPicker extends StatelessWidget {
  const OurNumberPicker({
    super.key,
    required this.seriesConter,
    required this.value,
    required this.maxValue,
    required this.onChanged,
  });

  final bool seriesConter;
  final int value;
  final int maxValue;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return NumberPicker(
      axis: Axis.vertical,
      itemWidth: 60,
      itemHeight: 35,
      itemCount: 3,
      value: value,
      minValue: seriesConter ? 1 : 0,
      maxValue: maxValue,
      onChanged: onChanged,
    );
  }
}
