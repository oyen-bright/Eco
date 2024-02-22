import 'package:emr_005/ui/components/wrappers/profile_view_wrapper.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/ecomoto/views/profile/dashboard/components/header/profile_header.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileViewWrapper(
      actions: [
        ProfileHeader(
          foregroundColor: context.colorScheme.onPrimary,
        )
      ],
      title: "Profile",
      body: const Column(
        children: [
          SizedBox(
            height: AppSizes.size10,
          ),
        ],
      ),
    );
  }
}
