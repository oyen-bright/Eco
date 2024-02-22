import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:flutter/material.dart';
import '../../../../../../ecomoto/views/profile/dashboard/components/header/name_avatar.dart';
import '../../../../bloc/community/community_feed_model.dart';

class EditCommunityPostHeader extends StatelessWidget {
  final CommunityPost communityPost;
  const EditCommunityPostHeader({
    super.key,
    required this.communityPost,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Text(
            'Edit Your Post',
            style: context.textTheme.titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close),
          ),
        ],
      ).withContentPadded,
      Divider(color: context.colorScheme.onBackground),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            NameAvatar(
              data: AppConstants.getUsernameInitials(communityPost.creatorUsername),
            ),
            const SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(communityPost.creatorUsername,
                    style: context.textTheme.titleSmall!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(AppConstants.formatCreatedAt(communityPost.createdAt),
                    style: context.textTheme.bodySmall!.copyWith())
              ],
            ),
          ],
        ),
      ]).withContentPadded
    ]);
  }




}
