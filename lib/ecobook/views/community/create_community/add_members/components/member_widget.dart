import 'package:emr_005/ecomoto/views/profile/dashboard/components/header/name_avatar.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:flutter/material.dart';

import '../../../../../../cubits/user_cubit/user_model.dart';

class MemberWidget extends StatelessWidget {
  final User user;
  const MemberWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    bool isChecked = true;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _memberInfo(),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: context.colorScheme.primary,
              width: 1.0,
            ),
          ),
          child: isChecked
              ? Icon(Icons.circle,
              size: 15, color: context.colorScheme.primary)
              : const SizedBox(
            width: 15,
            height: 15,
          ),
        ),
      ],
    );
  }
  Row _memberInfo () {
    return  Row(
      children: [
        NameAvatar(data: user.username),

        Text(user.username)
      ],
    );
  }
}