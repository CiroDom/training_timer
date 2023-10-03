import 'package:flutter/material.dart';
import 'package:training_timer/ui/res/our_colors.dart';

class DialogSeparator extends StatelessWidget {
  const DialogSeparator({super.key, required this.categName, required this.darkMode});

  final String categName;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 2,
              color: darkMode ? OurColors.textsD : OurColors.textsL,
            ),
          ),
          Text(' $categName '),
          Expanded(
            child: Container(
              height: 2,
              color: darkMode ? OurColors.textsD : OurColors.textsL,
            ),
          ),
        ],
      ),
    );
  }
}
