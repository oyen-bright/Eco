import 'package:flutter/material.dart';

class MoreButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color? color;
  const MoreButton({super.key, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: color, onPressed: onPressed, icon: const Icon(Icons.menu));
  }
}
