import 'package:flutter/material.dart';

class KeyBoardDismissWrapper extends StatelessWidget {
  final Widget child;
  const KeyBoardDismissWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
