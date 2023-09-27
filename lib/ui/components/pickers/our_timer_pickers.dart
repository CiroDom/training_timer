import 'package:flutter/material.dart';

import '../../../core/enums/time_train_picker_infos.dart';
import 'our_number_picker.dart';

class OurTimerPickers extends StatelessWidget {
  const OurTimerPickers(
      {super.key,
      required this.darkMode,
      required this.timeTrainPickerInfos,
      required this.getSetterList,
      required this.getGetterList, required this.doubleTapFunc});

  final bool darkMode;
  final List<TimeTrainPickerInfos> timeTrainPickerInfos;
  final List<int> getGetterList;
  final List<void Function(int)> getSetterList;
  final List<VoidCallback> doubleTapFunc;

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
            return Expanded(
              child: OurNumberPicker(
                    darkMode: darkMode,
                    minValue: timeTrainPickerInfos[i].minValue,
                    maxValue: timeTrainPickerInfos[i].maxValue,
                    unity: timeTrainPickerInfos[i].unity,
                    value: getGetterList[i],
                    onChanged: (value) => getSetterList[i](value),
                    doubleTapFunc: doubleTapFunc[i],
                  )
            );
          }),
        ),
        const Text('Descanso:'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(2, (index) {
            final j = index + 1;
            final i = index + 3;
            return Expanded(
              child: OurNumberPicker(
                darkMode: darkMode,
                minValue: timeTrainPickerInfos[j].minValue,
                maxValue: timeTrainPickerInfos[j].maxValue,
                unity: timeTrainPickerInfos[j].unity,
                value: getGetterList[i],
                onChanged: (value) => getSetterList[i](value),
                doubleTapFunc: doubleTapFunc[i],
              )
            );
          }),
        )
      ],
    );
  }
}
