import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

Future<void> openAppSettings() async {
  String settingsUrl;
  if (Platform.isIOS) {
    settingsUrl = 'app-settings:';
  } else {
    settingsUrl = 'package:com.example.emr_005';
  }

  if (await canLaunchUrl(Uri.parse(settingsUrl))) {
    await launchUrl(Uri.parse(settingsUrl));
  } else {}
}
