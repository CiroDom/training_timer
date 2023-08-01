import 'package:flutter/material.dart';

class NextStepButton extends StatelessWidget {
  const NextStepButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 184.0,
      height: 48.0,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(text)),
    );
  }
}
