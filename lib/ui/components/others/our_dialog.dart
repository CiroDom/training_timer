
import 'package:flutter/material.dart';

import '../pickers/our_number_picker.dart';

class OurDialog extends StatelessWidget {
  const OurDialog(
      {super.key,
      required this.listNames,
      required this.selectedsList,
      required this.onChangedPicker,
      required this.onChangedCheckbox,
      required this.doubleTapFunc,
      required this.howManyVoices,
      required this.darkMode,});

  final List<String> listNames;
  final List<bool> selectedsList; 
  final void Function(int) onChangedPicker;
  final void Function(int) onChangedCheckbox;
  final VoidCallback doubleTapFunc;
  final int howManyVoices;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('configurações da contagem regressiva'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OurNumberPicker(
            value: 5,
            minValue: 3,
            maxValue: 10,
            onChanged: onChangedPicker,
            doubleTapFunc: doubleTapFunc,
            darkMode: darkMode,
          ),
          Column(
            children: List.generate(howManyVoices, (index) => CheckboxListTile(
              title: Text(listNames[index]),
              value: selectedsList[index],
              onChanged: (index) => onChangedCheckbox)),

          ),
        ],
      ),
    );
  }
}
