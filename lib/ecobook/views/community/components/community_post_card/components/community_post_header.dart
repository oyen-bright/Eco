import 'package:emr_005/data/local_storage/local_storage.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../config/app_constants.dart';
import '../../../../../../ecomoto/views/profile/dashboard/components/header/name_avatar.dart';
import '../../../../../../ui/components/dialogs/post_delete_dialog.dart';
import '../../../../../bloc/community/community_bloc.dart';
import '../../../../../bloc/community/community_feed_model.dart';
import '../../../../../bloc/community/community_model.dart';
import '../../../edit_post/edit_post_view.dart';

class CommunityPostHeader extends StatelessWidget {
  final CommunityPost communityPost;
  final Community community;
  const CommunityPostHeader({
    super.key,
    required this.communityPost, required this.community,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppConstants.contentPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                NameAvatar(
                  data: AppConstants.getUsernameInitials(communityPost.creatorUsername),
                ),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Row(
                      children: [
                        Text(communityPost.creatorUsername,
                            style: context.textTheme.titleSmall!
                                .copyWith(fontWeight: FontWeight.bold)),

                        const SizedBox(width: 10,),
                        Text(AppConstants.formatCreatedAt(communityPost.createdAt),
                            style: context.textTheme.bodySmall!.copyWith()),

                      ],
                    ),

                    Container(
                      decoration: BoxDecoration(
                          color: context.colorScheme.primary
                      ),
                      child: Text(' ${community.name} ',
                          maxLines: 1,
                          style: context.textTheme.bodySmall!.copyWith(
                              color: context.colorScheme.background,
                              fontSize: 10)),
                    )




                  ],
                ),

              ],
            ),

            _MorePopUpMenu(communityPost, community)
          ],
        ));
  }



}

class _MorePopUpMenu extends StatelessWidget {
  final CommunityPost communityPost;
  final Community community;
  const _MorePopUpMenu(this.communityPost, this.community);

  @override
  Widget build(BuildContext context) {
    final options = communityPost.creatorId == LocalStorage.userId
        ? [
      (communityPost.isLiked) ?
      ('unlike', 'Unlike Post', null)
          : ('like', 'Like Post', null),
      ('edit', 'Edit Post', null),
      ('delete', 'Delete Post', Colors.red),
    ]
        : [
      (communityPost.isLiked) ?
      ('unlike', 'Unlike Post', null)
          : ('like', 'Like Post', null),
      // ('edit_post', 'Edit Post', null),
      // ('delete_post', 'Delete Post', Colors.red),
    ];

    return SizedBox(
      height: 20,
      child: PopupMenuButton<String>(
        // constraints: BoxConstraints.tight(const Size.fromHeight(5)),
        offset: const Offset(-5, 20),
        padding: EdgeInsets.zero,
        elevation: 1,
        itemBuilder: (context) {
          return options
              .map(
                (e) => PopupMenuItem<String>(
              height: kMinInteractiveDimension - 5,
              value: e.$1,
              child: Text(
                e.$2,
                style: context.textTheme.labelLarge?.copyWith(color: e.$3),
              ),
            ),
          )
              .toList();
        },
        onSelected: (value) {
          if (value == "like") {
            _onFeedLikeButton(context);
            print('Like Pressed');
          }

          if (value == "unlike") {
            _onFeedLikeButton(context);
            print('Unlike Pressed');
          }

          if (value == "edit") {
            EditCommunityPostView(communityPost: communityPost, community: community,).asBottomSheet(
                context,
                enableDrag: false
            );
          }

          if (value == "delete") {
            ShowDeleteDialog(
                onYesPressed: _onDelete(context, communityPost.id!)).asDialog(context);
          }
        },
      ),
    );
  }

  void _onFeedLikeButton(BuildContext context) {
    final String feedId = communityPost.id!;
    final bool isLiked = communityPost.isLiked;

    context.read<CommunityBloc>()
        .add(CommunityEvent.likeCommunityFeed(postId: feedId, isLiked: isLiked, communityId: community.id!));
  }

  void Function() _onDelete(BuildContext context, String postId) {
    return () {
      context.read<CommunityBloc>().add(CommunityEvent.deleteCommunityPost(postId: postId, communityId: community.id! ));
    };
  }


  Future<void> showComment(
      {required BuildContext context, required Widget child}) async {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      enableDrag: false,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return child;
      },
    );
  }
}

