import 'package:flutter/material.dart';
import 'package:training_timer/core/enums/countdown_alarms.dart';
import 'package:training_timer/core/enums/countdown_voices.dart';
import 'package:training_timer/core/view_models/training_vms/timer_training_vms/vm_timer_edit_view.dart';
import 'package:training_timer/ui/components/others/dialog_separator.dart';

import '../pickers/our_number_picker.dart';

class OurDialog extends StatelessWidget {
  const OurDialog({
    super.key,
    required this.viewModel,
    required this.darkMode,
  });

  final VmTimerEditView viewModel;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('configurações da contagem regressiva'),
      content: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: viewModel,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DialogSeparator(categName: 'Início da contagem', darkMode: darkMode),
                OurNumberPicker(
                  value: viewModel.getCountdown,
                  minValue: 3,
                  maxValue: 10,
                  onChanged: (number) => viewModel.setCountdown = number,
                  doubleTapFunc: () {},
                  darkMode: darkMode,
                ),
                DialogSeparator(categName: 'Voz da contagem', darkMode: darkMode),
                ...List.generate(
                    viewModel.getListVoiceFiles.length,
                    (index) => CheckboxListTile(
                        title: Text(viewModel.getListVoiceTitles[index]),
                        value: viewModel.getListVoiceSelec[index],
                        onChanged: (boolValue) => viewModel.selectVoice(index))),
                DialogSeparator(categName: 'Alarme final', darkMode: darkMode),
                ...List.generate(
                    viewModel.getListAlarmFiles.length,
                    (index) => CheckboxListTile(
                      title: Text(viewModel.getListAlarmTitles[index]),
                      value: viewModel.getListAlarmSelec[index],
                      onChanged: (boolValue) => viewModel.selectAlarm(index)))
              ],
            );
          }
        ),
      ),
    );
  }
}


