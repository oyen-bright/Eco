import 'package:flutter/material.dart';

extension ColorExtention on Color {
  String get toHex {
    return '#${value.toRadixString(16).substring(2).toUpperCase()}';
  }
}
