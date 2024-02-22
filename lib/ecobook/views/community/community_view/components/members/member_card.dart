import 'package:emr_005/data/local_storage/local_storage.dart';
import 'package:emr_005/ecobook/bloc/community/members_model.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/app_constants.dart';
import '../../../../../../ecomoto/views/profile/dashboard/components/header/name_avatar.dart';
import '../../../../../../themes/app_images.dart';
import '../../../../../../themes/sizes.dart';
import '../../../../../../ui/components/widgets/shimmer.dart';


class MemberCard extends StatefulWidget {
  final Member member;
  const MemberCard({
    Key? key,
    required this.member,
  }) : super(key: key);

  static Widget get shimmer {
    return AppShimmer(
      child: MemberCard(
        member: Member.dummy(),
      ),
    );
  }
  @override
  State<MemberCard> createState() => MemberCardState();
}

class MemberCardState extends State<MemberCard> {
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0.0,
        child: Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              onTap: () {
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(AppConstants.borderRadius),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.viewPaddingHorizontal),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _userInfo(username: widget.member.username!),

                      (widget.member.id == LocalStorage.userId) ?
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Leave',
                            style: context.textTheme.bodySmall!.copyWith(
                                color: context.colorScheme.error,
                                fontWeight: FontWeight.bold),
                          ))

                          : InkWell(
                          onTap: () {},
                          child: SizedBox(
                            height: context.viewSize.width * .08,
                            width: context.viewSize.width * .08,
                            child: Image.asset(AppImages.addFriend),
                          ))
                    ],
                  )),
            ),
             Divider(color: context.colorScheme.onBackground, thickness: .50,).withHorViewPadding
          ],
        ));
  }


  Row _userInfo({required String username}) {
    return Row(
      children: [
        NameAvatar(data: AppConstants.getUsernameInitials(username)),
        const SizedBox(
          width: AppSizes.size6,
        ),
        Text(
          username,
          style: context.textTheme.titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

}