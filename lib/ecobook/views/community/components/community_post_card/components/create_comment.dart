import 'dart:async';

import 'package:emr_005/ecobook/bloc/community/community_bloc.dart';
import 'package:emr_005/ecobook/bloc/community/community_model.dart';
import 'package:emr_005/ecobook/models/create_comment.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../cubits/user_cubit/user_cubit.dart';
import '../../../../../../ecomoto/views/profile/dashboard/components/header/name_avatar.dart';
import '../../../../../../themes/sizes.dart';
import '../../../../../../utils/enums.dart';

class CreateCommunityPostComment extends StatefulWidget {
  final Community community;
  final String feedId;
  const CreateCommunityPostComment(
      {super.key, required this.feedId, required this.community,});

  @override
  CreateCommunityPostCommentState createState() => CreateCommunityPostCommentState();
}

class CreateCommunityPostCommentState extends State<CreateCommunityPostComment> {
  final commentInputData = CommentModel();


  late final TextEditingController _commentInputController;


  Future<void> _communityFeedComment(CommunityBloc communityBloc) async {
    if (_commentInputController.text.isNotEmpty) {
      context.removeFocus;

      try {
        communityBloc.add(CommunityEvent.commentOnCommunityPost(postId :  widget.feedId,
            comment :  _commentInputController.text,
            communityId: widget.community.id!));
        _commentInputController.clear();
      } catch(e) {
        print(e);
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
          child:  Row(
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
                onTap: () => _communityFeedComment(context.read<CommunityBloc>()),
                child: Transform.scale(
                  scale: .90,
                  child: Icon(
                    Icons.send,
                    color: context.colorScheme.primary,
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
