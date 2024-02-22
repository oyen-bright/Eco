import 'package:emr_005/ecobook/bloc/feed/feed_model.dart';
import 'package:emr_005/ecobook/views/ecobook_feed/components/user_post_card/components/post_media_viewer.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';


import '../../../../../../themes/app_colors.dart';


class UserPostContent extends StatefulWidget {
  final FeedPost feedPost;

  const UserPostContent({
    super.key,
    required this.feedPost,
  });

  @override
  UserPostContentState createState() => UserPostContentState();
}

class UserPostContentState extends State<UserPostContent> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ReadMoreText(
              widget.feedPost.content!,
              trimLines: 16,
              textAlign: TextAlign.justify,
              trimMode: TrimMode.Line,
              trimCollapsedText: " Show More",
              moreStyle: context.textTheme.bodySmall!.copyWith(
                color: AppColors.hyperLinkColor,
              ),
              trimExpandedText: " Show less",
              lessStyle: context.textTheme.bodySmall!.copyWith(
                color: AppColors.hyperLinkColor,
              ),
              style: context.textTheme.bodyLarge!
                  .copyWith(color: AppColors.postTextColor),
            )),
        if ((widget.feedPost.imageUrl != null &&
            widget.feedPost.imageUrl!.isNotEmpty))

          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 300,
            ),
            child: PostMediaViewer(
              itemCount: widget.feedPost.imageUrl!.length,
              imageUrl: widget.feedPost.imageUrl!,
              mediaLength: widget.feedPost.imageUrl!.length,
            ),
          ),

      ],
    );
  }
}
