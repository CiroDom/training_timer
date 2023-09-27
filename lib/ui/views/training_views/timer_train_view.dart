import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/time_train_picker_infos.dart';
import '../../../core/view_models/training_vms/timer_training_vms/vm_edit_timer.dart';
import '../../components/buttons/next_step_button.dart';
import '../../components/pickers/our_serie_picker.dart';
import '../../components/pickers/our_timer_pickers.dart';
import '../../provider_models/theme_model.dart';

class TimerTrainView extends StatelessWidget {
  final VmEditTimer viewModel;

  const TimerTrainView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness != Brightness.light;

    return AnimatedBuilder(
        animation: viewModel,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              actions: [
                IconButton(
                  icon: Icon(
                      Provider.of<ThemeModel>(context, listen: false).getIcon),
                  onPressed: Provider.of<ThemeModel>(context, listen: false)
                      .switchThemeMode,
                )
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OurSeriePicker(
                    darkMode: darkMode,
                    minValue: TimeTrainPickerInfos.values[0].minValue,
                    maxValue: TimeTrainPickerInfos.values[0].maxValue,
                    value: viewModel.getSeriesNumber,
                    setter: viewModel.getSetterList()[0],
                    doubleTapFunc: viewModel.getAddNumberList()[0]),
                OurTimerPickers(
                  darkMode: darkMode,
                  timeTrainPickerInfos: TimeTrainPickerInfos.values,
                  getSetterList: viewModel.getSetterList(),
                  getGetterList: viewModel.getGetterList(),
                  doubleTapFunc: viewModel.getAddNumberList(),
                ),
                NextStepButton(
                    text: 'Próximo',
                    onPressed: () => viewModel.goToTimerView(context)),
              ],
            ),
          );
        });
  }
}
