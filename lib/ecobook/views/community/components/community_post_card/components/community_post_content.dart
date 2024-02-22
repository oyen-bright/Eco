import 'package:emr_005/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../../../../../../themes/app_colors.dart';
import '../../../../../bloc/community/community_feed_model.dart';
import '../../../../ecobook_feed/components/user_post_card/components/post_media_viewer.dart';

class CommunityPostContent extends StatefulWidget {
  final CommunityPost communityPost;

  const CommunityPostContent(
      {super.key, required this.communityPost,});

  @override
  CommunityPostContentState createState() => CommunityPostContentState();

}

class CommunityPostContentState extends State<CommunityPostContent> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ReadMoreText(
              widget.communityPost.content!,
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

        if ((widget.communityPost.imageUrl != null &&
            widget.communityPost.imageUrl!.isNotEmpty))
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 300,
            ),
            child: PostMediaViewer(
              itemCount: widget.communityPost.imageUrl!.length,
              imageUrl: widget.communityPost.imageUrl!,
              mediaLength: widget.communityPost.imageUrl!.length,
            ),
          ),

        // Container(
        //   child: VideoThumbnailBuilder(
        //     videoURL: 'videoUrl' ?? "",
        //     withPinata: true,
        //   ),
        // )
      ],
    );
  }
}
