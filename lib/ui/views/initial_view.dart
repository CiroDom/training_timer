import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_timer/core/view_models/vm_initial_view.dart';

import '../components/our_number_picker.dart';
import '../provider_models/theme_model.dart';

class InitialView extends StatelessWidget {
  final VmInitialView viewModel;

  const InitialView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    const maxHourAndSeries = 99;
    const maxMinAndSec = 59;
    const spaceBetween = 20.0;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(
              Provider.of<ThemeModel>(context, listen: false).getIcon),
            onPressed:
                Provider.of<ThemeModel>(context, listen: false).switchThemeMode,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: viewModel,
              builder: (context, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OurNumberPicker(
                          seriesConter: true,
                          value: viewModel.getSeriesNumber,
                          maxValue: maxHourAndSeries,
                          onChanged: (series) => viewModel.setSeriesNumber = series,
                        )
                      ],
                    ),
                    const SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OurNumberPicker(
                          seriesConter: false,
                          value: viewModel.getExecHour,
                          maxValue: maxHourAndSeries,
                          onChanged: (hours) => viewModel.setExecHour = hours,
                        ),
                        const SizedBox(
                          width: spaceBetween,
                        ),
                        OurNumberPicker(
                          seriesConter: false,
                          value: viewModel.getExecMin,
                          maxValue: maxMinAndSec,
                          onChanged: (mins) => viewModel.setExecMin = mins,
                        ),
                        const SizedBox(
                          width: spaceBetween,
                        ),
                        OurNumberPicker(
                          seriesConter: false,
                          value: viewModel.getExecSec,
                          maxValue: maxMinAndSec,
                          onChanged: (secs) => viewModel.setExecSec = secs,
                        ),
                        const SizedBox(
                          width: spaceBetween,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OurNumberPicker(
                          seriesConter: false,
                          value: viewModel.getRestHour,
                          maxValue: maxHourAndSeries,
                          onChanged: (hours) => viewModel.setRestHour = hours,
                        ),
                        const SizedBox(
                          width: spaceBetween,
                        ),
                        OurNumberPicker(
                          seriesConter: false,
                          value: viewModel.getRestMin,
                          maxValue: maxMinAndSec,
                          onChanged: (mins) => viewModel.setRestMin = mins,
                        ),
                        const SizedBox(
                          width: spaceBetween,
                        ),
                        OurNumberPicker(
                          seriesConter: false,
                          value: viewModel.getRestSec,
                          maxValue: maxMinAndSec,
                          onChanged: (secs) => viewModel.setRestSec = secs,
                        ),
                        const SizedBox(
                          width: spaceBetween,
                        ),
                      ],
                    ),
                  ],
                );
              }),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () => viewModel.goToTimerView(context),
              child: const Text('Botão')
          ),
        ],
      ),
    );
  }
}
