import 'package:emr_005/ecobook/bloc/community/community_bloc.dart';
import 'package:emr_005/ecobook/views/community/components/community_post_card/components/community_comment_section.dart';
import 'package:emr_005/ecobook/views/community/components/community_post_card/components/create_comment.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../ecobook/models/create_comment.dart';
import '../../../../../../themes/app_colors.dart';
import '../../../../../../themes/app_images.dart';
import '../../../../../../themes/sizes.dart';
import '../../../../../bloc/community/community_feed_model.dart';
import '../../../../../bloc/community/community_model.dart';

class CommunityPostInteraction extends StatefulWidget {
  final CommunityPost communityPost;
  final Community community;

  const CommunityPostInteraction(
      {super.key, required this.communityPost, required this.community, });

  @override
  CommunityPostInteractionState createState() => CommunityPostInteractionState();
}

class CommunityPostInteractionState extends State<CommunityPostInteraction> {
  final likeModel = LikeModel();

  void _onFeedLikeButton() {
    final String feedId = widget.communityPost.id!;
    final bool isLiked = widget.communityPost.isLiked;

    context
        .read<CommunityBloc>()
        .add(CommunityEvent.likeCommunityFeed(postId: feedId, isLiked: isLiked, communityId: widget.community.id!));
  }

  @override
  Widget build(BuildContext context) {
    return _buildCommunityInteraction(context).withContentPadded;
  }


  Column _buildCommunityInteraction(BuildContext context) {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: _onFeedLikeButton,
                  child: postInteractLikeButton(
                      isLiked: widget.communityPost.isLiked ?? false),
                ),

                if (widget.communityPost.feedLikes.isNotEmpty)
                  Text(widget.communityPost.feedLikes.length.toString())

                ]),

                const SizedBox(width: AppSizes.size6),
                InkWell(
                  child: Row(
                    children: [
                      postInteractCommentButton(),
                      Text(
                         (widget.communityPost.comments !=null)
                             ? widget.communityPost.comments!.length.toString()
                      : '0'
                      )
                    ],
                  ),
                  onTap: () {
                    context.read<CommunityBloc>().add(CommunityEvent.loadCommunityFeedComments(postId : widget.communityPost.id!, communityId: widget.community.id! ));
                    showComment(
                        context: context,
                        child: CommunityPostCommentSection(
                          community: widget.community,
                          communityPost: widget.communityPost,
                        ));
                  },
                ),
              ],
            ),

        const SizedBox(height: 8.0),
        (widget.communityPost.comments !=null && widget.communityPost.comments!.isNotEmpty)
            ? Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
              onTap: () {
                context.read<CommunityBloc>().add(CommunityEvent.loadCommunityFeedComments(postId : widget.communityPost.id!, communityId: widget.community.id! ));
                showComment(
                    context: context,
                    child: CommunityPostCommentSection(
                      community: widget.community,
                      communityPost: widget.communityPost,
                    ));
              },
              child: Text(
                'View all comments',
                style: context.textTheme.bodyMedium!
                    .copyWith(color: AppColors.lowOpacityTextColor),
              )),
        )
            : const SizedBox(),
        CreateCommunityPostComment(
          community: widget.community,
          feedId: widget.communityPost.id!,
        ),
      ],
    );
  }

  SizedBox postInteractLikeButton({required bool isLiked}) {
    return SizedBox(
      height: context.viewSize.width * .075,
      width: context.viewSize.width * .075,
      child: Image.asset(isLiked ? AppImages.likedIcon : AppImages.likeIcon),
    );
  }

  SizedBox postInteractCommentButton() {
    return SizedBox(
      height: context.viewSize.width * .075,
      width: context.viewSize.width * .075,
      child: Image.asset(AppImages.commentsIcon),
    );
  }

  Future<void> showComment(
      {required BuildContext context, required Widget child}) async {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return child;
      },
    );
  }
}
