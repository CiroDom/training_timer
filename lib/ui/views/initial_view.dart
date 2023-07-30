import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_timer/core/classes/enum/time_train_picker_infos.dart';
import 'package:training_timer/core/view_models/vm_initial_view.dart';
import 'package:training_timer/ui/views/our_styles.dart';

import '../components/our_number_picker.dart';
import '../provider_models/theme_model.dart';

class InitialView extends StatelessWidget {
  final VmInitialView viewModel;

  const InitialView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    const maxHourAndSeries = 99;
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Séries:'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OurNumberPicker(
                          value: viewModel.getSeriesNumber,
                          maxValue: maxHourAndSeries,
                          onChanged: (series) =>
                              viewModel.setSeriesNumber = series,
                          darkMode: darkMode,
                          minValue: 1,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text('Execução:'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        final i = index + 1;
                        return OurNumberPicker(
                          darkMode: darkMode,
                          minValue: TimeTrainPickerInfos.values[i].minValue,
                          maxValue: TimeTrainPickerInfos.values[i].maxValue,
                          value: viewModel.getGetterList()[i],
                          onChanged: (value) =>
                              viewModel.getSetterList()[i](value),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text('Descanso:'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        final i = index + 4;
                        final j = index + 1;
                        return OurNumberPicker(
                          darkMode: darkMode,
                          minValue: TimeTrainPickerInfos.values[j].minValue,
                          maxValue: TimeTrainPickerInfos.values[j].maxValue,
                          value: viewModel.getGetterList()[i],
                          onChanged: (value) =>
                              viewModel.getSetterList()[i](value),
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () => viewModel.goToTimerView(context),
                    child: const Text('Próximo')),
              ],
            ),
          );
        });
  }
}
