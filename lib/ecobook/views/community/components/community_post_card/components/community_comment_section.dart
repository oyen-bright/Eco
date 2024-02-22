import 'package:emr_005/ecobook/bloc/community/community_feed_model.dart';
import 'package:emr_005/ecobook/views/community/components/community_post_card/components/create_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/sizes.dart';
import '../../../../../../config/app_constants.dart';
import '../../../../../bloc/community/community_bloc.dart';
import '../../../../../bloc/community/community_model.dart';
import 'community_post_comment_card.dart';

class CommunityPostCommentSection extends StatefulWidget {
  final ScrollController? scrollController;
  final CommunityPost communityPost;
  final Community community;

  const CommunityPostCommentSection({
    Key? key,
    this.scrollController,
    required this.communityPost, required this.community,
  }) : super(key: key);

  @override
  State<CommunityPostCommentSection> createState() =>
      CommunityPostCommentSectionState();
}

class CommunityPostCommentSectionState extends State<CommunityPostCommentSection> {
  final ScrollController _scrollbarController = ScrollController();

  @override
  void initState() {
    context.read<CommunityBloc>().add(CommunityEvent.loadCommunityFeedComments(postId : widget.communityPost.id!, communityId: widget.community.id! ));
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
                  'Comments (${widget.communityPost.comments!.length})',
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
                  child: BlocConsumer<CommunityBloc, CommunityState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        error: (message, _, feeds, ___) {
                          context.showSnackBar(message);
                        },
                        orElse: () {},
                      );
                    },
                    builder: (context, state) {
                      return _buildCommentList(context, state.communityFeeds!);
                    },
                  ),
                ),
              ),
              CreateCommunityPostComment(
                community: widget.community,
                  feedId: widget.communityPost.id!),
            ],
          ).withContentPadded,
        );
      },
    );
  }

  Widget _buildCommentList(BuildContext context, List<CommunityPost> feeds) {
    final communityPost = feeds.firstWhere(
          (element) => element.id == widget.communityPost.id,
      orElse: () => widget.communityPost,
    );

    return ListView.builder(
      controller: _scrollbarController,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.viewPaddingVertical,
      ),
      scrollDirection: Axis.vertical,
      itemCount: communityPost.comments!.length,
      itemBuilder: (buildContext, int index) {
        return CommunityPostCommentCard(comment: communityPost.comments![index]);
      },
    );
  }
}
