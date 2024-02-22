import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int totalRating;
  final int currentRating;
  final double size;
  final Color? color;

  const StarRating({
    Key? key,
    this.totalRating = 5,
    required this.currentRating,
    this.size = 24.0,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalRating, (index) {
        return Icon(
          index < currentRating ? Icons.star : Icons.star_border,
          color: color ?? Colors.amber,
          size: size,
        );
      }),
    );
  }
}
