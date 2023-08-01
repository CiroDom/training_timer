import 'package:flutter/material.dart';

import '../../../core/classes/enum/time_train_picker_infos.dart';
import 'our_number_picker.dart';

class OurTimerPickers extends StatelessWidget {
  const OurTimerPickers(
      {super.key,
      required this.darkMode,
      required this.timeTrainPickerInfos,
      required this.getSetterList,
      required this.getGetterList});

  final bool darkMode;
  final List<TimeTrainPickerInfos> timeTrainPickerInfos;
  final List<int> getGetterList;
  final List<void Function(int)> getSetterList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Execução:'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(2, (index) {
            final i = index + 1;
            return OurNumberPicker(
              darkMode: darkMode,
              minValue: timeTrainPickerInfos[i].minValue,
              maxValue: timeTrainPickerInfos[i].maxValue,
              unity: timeTrainPickerInfos[i].unity,
              value: getGetterList[i],
              onChanged: (value) => getSetterList[i](value),
            );
          }),
        ),
        const Text('Descanso:'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(2, (index) {
            final i = index + 3;
            final j = index + 1;
            return OurNumberPicker(
              darkMode: darkMode,
              minValue: TimeTrainPickerInfos.values[j].minValue,
              maxValue: TimeTrainPickerInfos.values[j].maxValue,
              unity: TimeTrainPickerInfos.values[j].unity,
              value: getGetterList[i],
              onChanged: (value) => getSetterList[i](value),
            );
          }),
        )
      ],
    );
  }
}
