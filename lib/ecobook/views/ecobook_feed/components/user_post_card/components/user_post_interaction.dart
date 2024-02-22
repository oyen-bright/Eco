import 'package:emr_005/ecobook/bloc/feed/feed_model.dart';
import 'package:emr_005/ecobook/views/ecobook_feed/components/user_post_card/components/user_post_comment_section.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../ecobook/models/create_comment.dart';
import '../../../../../../themes/app_colors.dart';
import '../../../../../../themes/app_images.dart';
import '../../../../../../themes/sizes.dart';
import '../../../../../bloc/feed/feed_bloc.dart';
import 'create_comment.dart';

class UserPostInteraction extends StatefulWidget {
  final FeedPost feedPost;

  const UserPostInteraction(
      {super.key, required this.feedPost, });

  @override
  UserPostInteractionState createState() => UserPostInteractionState();
}

class UserPostInteractionState extends State<UserPostInteraction> {
  final likeModel = LikeModel();


  void _onFeedLikeButton() {
    final String feedId = widget.feedPost.id!;
    final bool isLiked = widget.feedPost.isLiked;

    context
        .read<FeedBloc>()
        .add(FeedEvent.likeFeedPost(postId: feedId, isLiked: isLiked));
  }

  @override
  Widget build(BuildContext context) {
    return _buildUserFeedInteractions(context);
  }


  Column _buildUserFeedInteractions(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: _onFeedLikeButton,
                  child: postInteractLikeButton(
                      isLiked: widget.feedPost.isLiked ?? false),
                ),

                if (widget.feedPost.feedLikes.isNotEmpty)
                  Text(widget.feedPost.feedLikes.length.toString())

              ],
            ),
            const SizedBox(width: AppSizes.size6),
            InkWell(
              child: Row(
                children: [
                  postInteractCommentButton(),
                  Text(widget.feedPost.comments!.length.toString())
                ],
              ),
              onTap: () {
                context.read<FeedBloc>().add(FeedEvent.loadFeedPostComments(widget.feedPost.id!));
                showComment(
                    context: context,
                    child: UserPostCommentSection(
                      feedPost: widget.feedPost,
                      // feedComment: widget.feedPost.comments!,
                    ));
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        (widget.feedPost.comments!.isNotEmpty)
            ? Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
              onTap: () {
                context.read<FeedBloc>().add(FeedEvent.loadFeedPostComments(widget.feedPost.id!));
                showComment(
                    context: context,
                    child: UserPostCommentSection(
                      feedPost: widget.feedPost,
                      // feedComment: widget.feedPost.comments!,
                    ));
              },
              child: Text(
                'View all comments',
                style: context.textTheme.bodyMedium!
                    .copyWith(color: AppColors.lowOpacityTextColor),
              )),
        )
            : const SizedBox(),
        CreatePostComment(
            feedId: widget.feedPost.id!
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


