import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

void shareFile(BuildContext context,
    {required String filePath,
    required String subject,
    required String text}) async {
  final result = await Share.shareXFiles([XFile(filePath)]);
  // await Share.shareXFiles([XFile(filePath)], subject: subject, text: text);

  if (result.status == ShareResultStatus.success) {}
}
