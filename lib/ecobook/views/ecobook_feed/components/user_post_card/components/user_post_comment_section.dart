import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emr_005/ecobook/bloc/feed/feed_model.dart';
import 'package:emr_005/ecobook/views/ecobook_feed/components/user_post_card/components/comment_card.dart';
import 'package:emr_005/ecobook/views/ecobook_feed/components/user_post_card/components/create_comment.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/sizes.dart';

import '../../../../../../config/app_constants.dart';
import '../../../../../bloc/feed/feed_bloc.dart';

class UserPostCommentSection extends StatefulWidget {
  final ScrollController? scrollController;
  final FeedPost feedPost;

  const UserPostCommentSection({
    Key? key,
    this.scrollController,
    required this.feedPost,
  }) : super(key: key);

  @override
  State<UserPostCommentSection> createState() =>
      UserPostCommentSectionState();
}

class UserPostCommentSectionState extends State<UserPostCommentSection> {
  final ScrollController _scrollbarController = ScrollController();

  @override
  void initState() {
    context.read<FeedBloc>().add(FeedEvent.loadFeedPostComments(widget.feedPost.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Text(
                  'Comments (${widget.feedPost.comments!.length})',
                  style: context.textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ).withContentPadded,
              ),
              const SizedBox(
                height: AppSizes.size10,
              ),
              Expanded(
                child: Scrollbar(
                  interactive: true,
                  thickness: 10,
                  radius: const Radius.circular(AppConstants.borderRadius),
                  controller: _scrollbarController,
                  thumbVisibility: true,
                  child: BlocConsumer<FeedBloc, FeedState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        error: (
                            message,
                            feeds,
                            ) {
                          context.showSnackBar(message);
                        },
                        orElse: () {},
                      );
                    },
                    builder: (context, state) {
                      return _buildCommentList(context, state.data);
                    },
                  ),
                ),
              ),
              CreatePostComment(feedId: widget.feedPost.id!),
            ],
          ).withContentPadded,
        );
      },
    );
  }

  Widget _buildCommentList(BuildContext context, List<FeedPost> feeds) {
    final feedPost = feeds.firstWhere(
          (element) => element.id == widget.feedPost.id,
      orElse: () => widget.feedPost,
    );

    return ListView.builder(
      controller: _scrollbarController,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.viewPaddingVertical,
      ),
      scrollDirection: Axis.vertical,
      itemCount: feedPost.comments!.length,
      itemBuilder: (buildContext, int index) {
        return UserPostCommentCard(comment: feedPost.comments![index]);
      },
    );
  }
}
