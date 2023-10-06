import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/view_models/training_vms/timer_training_vms/vm_timer_play_view.dart';
import '../../../components/buttons/next_step_button.dart';
import '../../../components/buttons/play_pause_row.dart';
import '../../../provider_models/theme_model.dart';
import '../../../res/our_colors.dart';
import '../../../res/our_styles.dart';

class TimerPlayView extends StatelessWidget {
  final VmTimerTimeView viewModel;
  const TimerPlayView({super.key, required this.viewModel});

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
              backgroundColor: viewModel.getTraining
                  ? darkMode
                      ? null
                      : viewModel.getRest
                          ? OurColors.stoppingActionL
                          : OurColors.continueingActionL
                  : darkMode
                    ? OurColors.backgroundD
                    : OurColors.backgroundL,
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
                        viewModel.getTraining
                            ? '${viewModel.getcurrentSerie.toString()} de ${viewModel.getTotalSeries}'
                            : '',
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
                          )
                        ),
                        Text(
                          viewModel.getOver
                          ? viewModel.getTimerMsg
                          : viewModel.getInitiated
                              ? '${viewModel.getStringMin}:${viewModel.getStringSec}'
                              : viewModel.getTimerMsg,
                          style: OurStyles.visual,
                        )
                      ]),
                      viewModel.getOver
                          ? NextStepButton(
                              text: 'Voltar',
                              onPressed: () => viewModel.goBack(context))
                          : viewModel.getTraining
                              ? PlayPauseRow(
                                  play: () {},
                                  pause: () {},
                                  paused: viewModel.getPaused)
                              : NextStepButton(
                                  text: 'Começar',
                                  onPressed: viewModel.start,
                                ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
