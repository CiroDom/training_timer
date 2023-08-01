import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:training_timer/ui/res/our_styles.dart';

class OurNumberPicker extends StatelessWidget {
  const OurNumberPicker({
    super.key,
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.unity,
    required this.onChanged,
    required this.darkMode,
  });

  final int value;
  final int minValue;
  final int maxValue;
  final String? unity;
  final void Function(int) onChanged;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NumberPicker(
            selectedTextStyle:
                darkMode ? OurStyles.pickerMainDark : OurStyles.pickerMainLight,
            textStyle: darkMode
                ? OurStyles.pickerSmallDark
                : OurStyles.pickerSmallLight,
            axis: Axis.vertical,
            itemWidth: 60,
            itemHeight: 35,
            itemCount: 3,
            value: value,
            minValue: minValue,
            maxValue: maxValue,
            onChanged: onChanged,
          ),
          unity == null
              ? const SizedBox()
              : Text(unity!),
        ],
      ),
    );
  }
}