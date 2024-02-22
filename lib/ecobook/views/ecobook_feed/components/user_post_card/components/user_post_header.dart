import 'package:emr_005/ecobook/bloc/feed/feed_model.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/ui/components/dialogs/post_delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../config/app_constants.dart';
import '../../../../../../data/local_storage/local_storage.dart';
import '../../../../../../ecomoto/views/profile/dashboard/components/header/name_avatar.dart';
import '../../../../../bloc/feed/feed_bloc.dart';
import '../../edit_post/edit_post_view.dart';

class UserPostHeader extends StatelessWidget {
  final FeedPost feedPost;
  const UserPostHeader({
    super.key,
    required this.feedPost,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: AppConstants.contentPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
              _MorePopUpMenu(feedPost)
          ],
        ));
  }



}

class _MorePopUpMenu extends StatelessWidget {
  final FeedPost feedPost;

  const _MorePopUpMenu(this.feedPost);

  @override
  Widget build(BuildContext context) {
    final options = feedPost.creatorId == LocalStorage.userId
        ? [
      (feedPost.isLiked) ?
      ('unlike', 'Unlike Post', null)
          : ('like', 'Like Post', null),
      ('edit', 'Edit Post', null),
      ('delete', 'Delete Post', Colors.red),

    ]
        : [
      (feedPost.isLiked) ?
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
            EditPostView(feedPost: feedPost,).asBottomSheet(
              context,
              enableDrag: false
            );
          }

          if (value == "delete") {
            ShowDeleteDialog(
                onYesPressed: _onDelete(context, feedPost.id!)).asDialog(context);
            print('Delete');
          }
        },
      ),
    );
  }

  void _onFeedLikeButton(BuildContext context) {
    final String feedId = feedPost.id!;
    final bool isLiked = feedPost.isLiked;

    context.read<FeedBloc>()
        .add(FeedEvent.likeFeedPost(postId: feedId, isLiked: isLiked));
  }

  void Function() _onDelete(BuildContext context, String postId) {
    return () {
      context.read<FeedBloc>().add(FeedEvent.deletePost(postId: postId));
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

