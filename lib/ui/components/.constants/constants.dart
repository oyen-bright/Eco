import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_animate/flutter_animate.dart';

@immutable
class Constants {
  const Constants._();

  static Duration successSnackBarDuration = 3.seconds;
  static Duration loadingSnackBarDuration = 10.seconds;
  static Duration actionSnackBarDuration = 10.seconds;
}
