import 'package:emr_005/controllers/app_scaffold_controller.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './more_button.dart';
import './name_avatar.dart';
import './name_text.dart';

class ProfileHeader extends StatelessWidget {
  final Color? foregroundColor;
  const ProfileHeader({super.key, this.foregroundColor});

  @override
  Widget build(BuildContext context) {
    final Color color = foregroundColor ?? context.colorScheme.onBackground;
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // const Expanded(
            //   child: Column(
            //     children: [Text("Wlcome"), Text("Annie Bassey")],
            //   ),
            // ),
            // NotificationIcon(
            //   color: color,
            // ),
            Padding(
              padding: const EdgeInsets.only(right: AppSizes.size4),
              child: NameAvatar(
                data: state.usernameInitials,
                backgroundColor: color,
              ),
            ),
            NameText(
                data: state.when<String>(
                  details: (user) => user.username,
                ),
                color: color),
            MoreButton(
              color: color,
              onPressed: context.read<AppScaffoldController>().openEndDrawer,
            ),
          ],
        );
      },
    );
  }
}
