import 'package:flutter/material.dart';

extension BuildContextExtention on Function {
  isMounted(BuildContext context) {
    if (context.mounted) {
      this();
    }
  }
}

extension BuildContextMountedExtension on BuildContext {
  void safeSetState(VoidCallback action) {
    if (mounted) {
      action();
    }
  }
}
