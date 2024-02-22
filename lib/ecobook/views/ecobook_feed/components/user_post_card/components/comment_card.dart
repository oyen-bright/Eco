import 'package:emr_005/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:emr_005/ecobook/bloc/feed/feed_comment_model.dart';

import '../../../../../../config/app_constants.dart';
import '../../../../../../data/local_storage/local_storage.dart';
import '../../../../../../ecomoto/views/profile/dashboard/components/header/name_avatar.dart';
import '../../../../../../themes/sizes.dart';
import '../../../../../../ui/components/widgets/shimmer.dart';

class UserPostCommentCard extends StatefulWidget {
  final Comment comment;
  const UserPostCommentCard({
    super.key,
    required this.comment,
  });

  static Widget get shimmer {
    return AppShimmer(
      child: UserPostCommentCard(
        comment: Comment.dummy(),
      ),
    );
  }

  @override
  State<UserPostCommentCard> createState() => _UserPostCommentCardState();
}

class _UserPostCommentCardState extends State<UserPostCommentCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NameAvatar(data: AppConstants.getUsernameInitials(widget.comment.creatorUsername!)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: AppSizes.size8),
              padding: AppConstants.contentPadding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                color: const Color(0xFFF0F2F5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.comment.creatorUsername!,
                    style: context.textTheme.titleSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: context.viewSize.width * .78,
                    child: Text(
                      widget.comment.comments!,
                      style: context.textTheme.bodyMedium!.copyWith(),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                InkWell(
                  child: Text('Like',
                      style: context.textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.bold)),
                  onTap: () {
                    print(widget.comment.comments!);
                  },
                ),
                const SizedBox(
                  width: AppSizes.size10,
                ),
                if (widget.comment.creatorId == LocalStorage.userId)
                  InkWell(
                    child: Text('Edit',
                        style: context.textTheme.bodySmall!
                            .copyWith(fontWeight: FontWeight.bold)),
                    onTap: () {
                      print(widget.comment.comments!);
                    },
                  ),
                const SizedBox(
                  width: AppSizes.size10,
                ),
                InkWell(
                  child: Text('Reply',
                      style: context.textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.bold)),
                  onTap: () {},
                ),
                const SizedBox(
                  width: AppSizes.size10,
                ),
                Text(
                  AppConstants.formatCreatedAt(widget.comment.createdAt!),
                  style: context.textTheme.labelSmall!.copyWith(),
                ),
              ],
            ),
            const SizedBox(
              height: AppSizes.size16,
            )
          ],
        ),
      ],
    );
  }




}
