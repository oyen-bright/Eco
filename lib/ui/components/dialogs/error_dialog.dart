import 'package:flutter/material.dart';

Future<void> showAppDialog(BuildContext context, String message,
    [List<Widget>? actions]) {
  return showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(message),
        actions: actions ??
            <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Okay'),
              ),
            ],
      );
    },
  );
}
