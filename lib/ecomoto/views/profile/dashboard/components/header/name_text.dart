import 'package:flutter/material.dart';

class NameText extends StatelessWidget {
  final String data;
  final Color? color;
  final FontWeight? fontWeight;

  const NameText({
    Key? key,
    required this.data,
    this.fontWeight,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(color: color, fontWeight: fontWeight ),
    );
  }
}
