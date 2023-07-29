import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_timer/core/view_models/vm_timer_view.dart';
import 'package:training_timer/ui/provider_models/theme_model.dart';
import 'package:training_timer/ui/res/our_colors.dart';

class TimerView extends StatelessWidget {
  final VmTimerView viewModel;
  const TimerView({super.key, required this.viewModel});

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness != Brightness.light;

    return AnimatedBuilder(
        animation: viewModel,
        builder: (context, child) {
          return WillPopScope(
            onWillPop: () async {
              viewModel.stopTimer();
              return true;
            },
            child: Scaffold(
              backgroundColor: darkMode
                  ? null
                  : viewModel.getRest
                      ? OurColors.stoppingActionL
                      : OurColors.continueingActionL,
              appBar: AppBar(
                elevation: 0.0,
                actions: [
                  IconButton(
                    icon: Icon(Provider.of<ThemeModel>(context, listen: false)
                        .getIcon),
                    onPressed: Provider.of<ThemeModel>(context, listen: false)
                        .switchThemeMode,
                  )
                ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(viewModel.getSeries.toString()),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Stack(alignment: Alignment.center, children: [
                          CircularProgressIndicator(
                            value: viewModel.getPercentageTime,
                            strokeWidth: 10,
                            backgroundColor: darkMode
                                ? OurColors.secondBackgroundD
                                : OurColors.secondBackgroundL,
                            valueColor: AlwaysStoppedAnimation<Color?>(
                                darkMode
                                    ? viewModel.getRest
                                        ? OurColors.stoppingActionD
                                        : OurColors.continueingActionD
                                    : null),
                          ),
                          Text(viewModel.getVisual)
                        ]),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          onPressed: viewModel.getOver ? null : viewModel.start,
                          child: const Text('Acionar'),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
