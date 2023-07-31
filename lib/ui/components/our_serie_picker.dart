import 'package:flutter/material.dart';

import 'our_number_picker.dart';

class OurSeriePicker extends StatelessWidget {
  const OurSeriePicker({super.key, required this.darkMode, required this.minValue, required this.maxValue, required this.value, required this.setter});

  final bool darkMode;
  final int minValue;
  final int maxValue;
  final int value;
  final void Function(int) setter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Séries:'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OurNumberPicker(
              darkMode: darkMode,
              minValue: minValue,
              maxValue: maxValue,
              value: value,
              unity: null,
              onChanged: (value) => setter(value),
            )
          ],
        )
      ],
    );
  }
}
