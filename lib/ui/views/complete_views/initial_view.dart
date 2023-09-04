import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_timer/core/classes/enum/time_train_picker_infos.dart';
import 'package:training_timer/core/presenters/pres_initial_view.dart';
import '../../components/buttons/next_step_button.dart';
import '../../components/pickers/our_serie_picker.dart';
import '../../components/pickers/our_timer_pickers.dart';
import '../../provider_models/theme_model.dart';
import '../pages/page_timer_train.dart';

class InitialView extends StatelessWidget {
  final PresInitialView presenter;

  const InitialView({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness != Brightness.light;

    return AnimatedBuilder(
        animation: presenter,
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
            body: PageView(
              children: [
                PageTimerTrain(darkMode: darkMode, presenter: presenter)
              ],
            ),
          );
        });
  }
}
