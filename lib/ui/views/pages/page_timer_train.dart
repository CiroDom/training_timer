import 'package:flutter/material.dart';

import '../../../core/classes/enum/time_train_picker_infos.dart';
import '../../../core/presenters/pres_initial_view.dart';
import '../../components/buttons/next_step_button.dart';
import '../../components/pickers/our_serie_picker.dart';
import '../../components/pickers/our_timer_pickers.dart';

class PageTimerTrain extends StatelessWidget {
  const PageTimerTrain({
    super.key,
    required this.darkMode,
    required this.presenter,
  });

  final bool darkMode;
  final PresInitialView presenter;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OurSeriePicker(
            darkMode: darkMode,
            minValue: TimeTrainPickerInfos.values[0].minValue,
            maxValue: TimeTrainPickerInfos.values[0].maxValue,
            value: presenter.getSeriesNumber,
            setter: presenter.getSetterList()[0],
            doubleTapFunc: presenter.getAddNumberList()[0]),
        OurTimerPickers(
          darkMode: darkMode,
          timeTrainPickerInfos: TimeTrainPickerInfos.values,
          getSetterList: presenter.getSetterList(),
          getGetterList: presenter.getGetterList(),
          doubleTapFunc: presenter.getAddNumberList(),
        ),
        NextStepButton(
            text: 'Próximo', onPressed: () => presenter.goToTimerView(context)),
      ],
    );
  }
}