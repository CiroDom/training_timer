import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_timer/core/view_models/vm_timer_view.dart';
import 'package:training_timer/ui/provider_models/theme_model.dart';

class TimerView extends StatelessWidget {
  final VmTimerView viewModel;
  const TimerView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final lightThemeMode =
        Provider.of<ThemeModel>(context, listen: false).getOurThemeMode == ThemeMode.light;

    return Scaffold(
      backgroundColor: lightThemeMode
          ? viewModel.getRest
              ? Colors.red
              : Colors.green
          : null,
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Provider.of<ThemeModel>(context, listen: false).getIcon),
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
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(viewModel.getSeries.toString()),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: viewModel.getPercentageTime,
                            strokeWidth: 10,
                            valueColor: AlwaysStoppedAnimation<MaterialColor?>(lightThemeMode ? null : viewModel.getRest ? Colors.red : Colors.green),
                          ),
                          Text(viewModel.getVisual)
                        ]
                      ),
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
                );
              }),
        ],
      ),
    );
  }
}
