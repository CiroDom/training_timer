import 'package:flutter/material.dart';
import 'package:training_timer/core/view_models/vm_timer_view.dart';

class TimerView extends StatelessWidget {
  final VmTimerView viewModel;
  const TimerView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: viewModel,
          builder: (context, child) {
            return Container(
              color: viewModel.getRest
                  ? Colors.green
                  : Colors.red,
              child: Text(viewModel.getVisual)
            );
          }
        ),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
          onPressed: viewModel.start,
          child: const Text('Acionar'),
        ),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
            onPressed: Navigator.of(context).pop, child: const Text('Voltar'))
      ],
    );
  }
}
