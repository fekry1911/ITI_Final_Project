import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onSkip;
  const SkipButton({super.key, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(onPressed: onSkip, child: const Text("Skip")),
    );
    ;
  }
}
