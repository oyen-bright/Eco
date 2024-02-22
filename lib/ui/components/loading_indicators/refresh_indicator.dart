import 'package:flutter/material.dart';

class AppRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Color? backgroundColor;
  final double displacement;
  final double edgeOffset;
  final Future<void> Function() onRefresh;

  const AppRefreshIndicator({
    Key? key,
    required this.child,
    this.color,
    this.backgroundColor,
    this.edgeOffset = 0.0,
    this.displacement = 40.0,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      edgeOffset: edgeOffset,
      color: color,
      backgroundColor: backgroundColor,
      displacement: displacement,
      child: child,
    );
  }
}
