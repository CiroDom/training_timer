import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_timer/core/view_models/vm_timer_view.dart';
import 'package:training_timer/ui/components/buttons/play_pause_row.dart';
import 'package:training_timer/ui/provider_models/theme_model.dart';
import 'package:training_timer/ui/res/our_colors.dart';
import 'package:training_timer/ui/res/our_styles.dart';

import '../components/buttons/next_step_button.dart';

class TimerView extends StatelessWidget {
  final VmTimerView viewModel;
  const TimerView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness != Brightness.light;

    return AnimatedBuilder(
        animation: viewModel,
        builder: (context, child) {
          return WillPopScope(
            onWillPop: () async {
              viewModel.totalCancel();
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
              body: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        viewModel.getCountdown
                            ? ''
                            : '${viewModel.getcurrentSerie.toString()} de ${viewModel.getTotalSeries}',
                        style: OurStyles.visual,
                      ),
                      Stack(alignment: Alignment.center, children: [
                        SizedBox(
                          width: 216,
                          height: 216,
                          child: CircularProgressIndicator(
                            value: viewModel.getPercentageTime,
                            strokeWidth: 24,
                            backgroundColor: darkMode
                                ? OurColors.divisorAndShadowNumberD
                                : OurColors.divisorAndShadowNumberL,
                            valueColor: AlwaysStoppedAnimation<Color?>(darkMode
                                ? viewModel.getRest
                                    ? OurColors.stoppingActionD
                                    : OurColors.continueingActionD
                                : null),
                          ),
                        ),
                        Text(
                          viewModel.getVisual,
                          style: OurStyles.visual,
                        )
                      ]),
                      
                      viewModel.getOver
                          ? NextStepButton(
                            text: 'Voltar',
                            onPressed: () => viewModel.goBack(context))
                          : viewModel.getCountdown
                              ? NextStepButton(
                                  text: 'Começar',
                                  onPressed: viewModel.getInitiated
                                      ? null
                                      : viewModel.start,
                                )
                              : PlayPauseRow(
                                  play: viewModel.continueTraining,
                                  pause: viewModel.pause,
                                  paused: viewModel.getPaused),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
