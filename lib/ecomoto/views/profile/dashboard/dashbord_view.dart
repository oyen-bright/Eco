import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/ui/components/wrappers/profile_view_wrapper.dart';
import 'package:flutter/material.dart';

import 'components/header/profile_header.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ProfileViewWrapper.withTitleWidget(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          actions: const [ProfileHeader()],
          background: const SizedBox.shrink(),
          titleWidget: Text(
            'Dashboard',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onBackground),
          ),
          body: const SizedBox.shrink(),
        )
      ],
    );
  }
}
