import 'package:flutter/material.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;
  const AppBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
