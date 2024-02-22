import 'package:flutter/material.dart';

MaterialBanner informationBanner(String data, List<Widget> actions) {
  return MaterialBanner(
    content: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.info,
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Text(
            data,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    ),
    actions: actions,
  );
}
