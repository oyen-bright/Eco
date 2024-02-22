import 'package:flutter/services.dart';

import 'enums.dart';

haptic(HapticFeedbackType type) {
  switch (type) {
    case HapticFeedbackType.light:
      HapticFeedback.lightImpact();
      break;
    case HapticFeedbackType.medium:
      HapticFeedback.mediumImpact();
      break;
    case HapticFeedbackType.heavy:
      HapticFeedback.heavyImpact();
      break;
    case HapticFeedbackType.selection:
      HapticFeedback.selectionClick();
      break;
    case HapticFeedbackType.vibrate:
      HapticFeedback.vibrate();
      break;
  }
}
