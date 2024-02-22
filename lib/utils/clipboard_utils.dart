import 'package:emr_005/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text))
      .then((value) => context.showSnackBar("Copied to Clipboard"));
}
