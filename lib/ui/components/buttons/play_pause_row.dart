import 'package:flutter/material.dart';

class PlayPauseRow extends StatelessWidget {
  const PlayPauseRow(
      {super.key,
      required this.play,
      required this.pause,
      required this.paused});

  final bool paused;
  final VoidCallback play;
  final VoidCallback pause;

  @override
  Widget build(BuildContext context) {
    const buttonWidth = 60.0;
    const buttonHeight = 60.0;
    final shape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000));

    return Row(
      children: [
        SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: shape),
              onPressed: paused ? play : null,
              child: const Icon(Icons.play_arrow)),
        ),
        const SizedBox(
          width: 20.0,
        ),
        SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: shape),
              onPressed: paused ? null : pause,
              child: const Icon(Icons.pause)),
        ),
      ],
    );
  }
}
