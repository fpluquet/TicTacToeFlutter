import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  final int index;

  final void Function(int index)? onPressed;

  final String text;

  const GameButton({
    super.key,
    required this.index,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        onPressed: onPressed != null
            ? () {
                onPressed!(index);
              }
            : null,
        child: Text(text,
            style: const TextStyle(
              fontSize: 32,
            )),
      ),
    );
  }
}
