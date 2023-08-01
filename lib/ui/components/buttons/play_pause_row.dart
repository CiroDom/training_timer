import 'package:flutter/material.dart';

class PlayPauseRow extends StatelessWidget {
  const PlayPauseRow(
      {super.key,
      required this.playOrPause,
      required this.goingOn});

  final bool goingOn;
  final VoidCallback playOrPause;

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
              onPressed: goingOn ? null : playOrPause,
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
              onPressed: goingOn ? playOrPause : null,
              child: const Icon(Icons.pause)),
        ),
      ],
    );
  }
}
