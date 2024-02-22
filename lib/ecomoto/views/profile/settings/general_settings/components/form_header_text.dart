import 'package:emr_005/extensions/context.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';

class FormHeaderText extends StatelessWidget {
  const FormHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        Strings.generalSettingsText,
        style: context.textTheme.titleLarge,
      ),
      Text(
        Strings.generalSettingsBodyText,
        style: context.textTheme.bodySmall,
      ),
    ]);
  }
}
