import 'dart:async';

import 'package:emr_005/ecobook/models/create_comment.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/user_cubit/user_cubit.dart';
import '../../../ecobook/bloc/feed/feed_bloc.dart';
import '../../../ecomoto/views/profile/dashboard/components/header/name_avatar.dart';
import '../../../themes/sizes.dart';
import '../../../utils/enums.dart';

class CreateCommentEcobook extends StatefulWidget {
  final bool isCommunity;
  final String feedId;
  const CreateCommentEcobook(
      {super.key, required this.feedId, this.isCommunity = false});

  @override
  CreateCommentEcobookState createState() => CreateCommentEcobookState();
}

class CreateCommentEcobookState extends State<CreateCommentEcobook> {
  final commentInputData = CommentModel();

   bool isCreatingComment = false;

  late final TextEditingController _commentInputController;

  // void _createOnCommunityFeed() async {
  //   if (_commentInputController.text.isNotEmpty) {
  //     context.removeFocus;
  //
  //     commentInputData.comment = _commentInputController.text;
  //     commentInputData.feedId = widget.feedId;
  //
  //     print(commentInputData);
  //
  //     final response = await context
  //         .read<EcobookService>()
  //         .createCommentOnCommunityFeed(commentModel: commentInputData);
  //
  //     if (mounted) {
  //       if (response.error == null) {
  //         context.showSnackBar('Comment Created');
  //         _commentInputController.clear();
  //       } else {
  //         print(commentInputData);
  //         context.showSnackBar(response.error, BarType.error);
  //       }
  //     }
  //   } else {
  //     context.showSnackBar('Write something', BarType.error);
  //   }
  // }

  Future<void> _userFeedComment(FeedBloc feedBloc) async {
    if (_commentInputController.text.isNotEmpty && !isCreatingComment) {
      context.removeFocus;

      setState(() {
        isCreatingComment = true;
      });

      try {
        FeedEvent.commentOnPost(widget.feedId, _commentInputController.text);
        _commentInputController.clear();
      } finally {
        setState(() {
          isCreatingComment = false;
        });
      }
    } else {
      context.showSnackBar('Write something', BarType.error);
    }
  }

  @override
  void initState() {
    super.initState();
    _commentInputController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _commentInputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: AppColors.postBackgroundColor,
            borderRadius: BorderRadius.circular(AppSizes.size30)),
        child: isCreatingComment
        ? const CircularProgressIndicator()
        : Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return Transform.scale(
                  scale: .90,
                  child: NameAvatar(data: state.usernameInitials),
                );
              },
            ),
            SizedBox(
              width: context.viewSize.width * .70,
              child: TextField(
                controller: _commentInputController,
                style: context.textTheme.bodyMedium!.copyWith(),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Comment something about this post...'),
              ),
            ),
            InkWell(
              onTap: () => _userFeedComment(context.read<FeedBloc>()),
              child: Transform.scale(
                scale: .90,
                child: Icon(
                  Icons.send,
                  color: context.colorScheme.primary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
