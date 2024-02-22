import 'package:emr_005/ecobook/bloc/feed/feed_model.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/app_constants.dart';
import '../../../../../../ecomoto/views/profile/dashboard/components/header/name_avatar.dart';

class EditPostHeader extends StatelessWidget {
  final FeedPost feedPost;
  const EditPostHeader({
    super.key,
    required this.feedPost,
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
              data: AppConstants.getUsernameInitials(feedPost.username),
            ),
            const SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(feedPost.username,
                    style: context.textTheme.titleSmall!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(AppConstants.formatCreatedAt(feedPost.createdAt),
                    style: context.textTheme.bodySmall!.copyWith())
              ],
            ),
          ],
        ),
      ]).withContentPadded
    ]);
  }
}
