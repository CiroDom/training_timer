import 'package:flutter/material.dart';

class ConfigButton extends StatelessWidget {
  const ConfigButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(onPressed: onPressed, icon: const Icon(Icons.settings)),
    );
  }
}
