library create_post;

import 'dart:io';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecobook/views/ecobook_feed/components/create_post/components/create_header.dart';
import 'package:emr_005/ecomoto/views/profile/dashboard/components/header/name_avatar.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../../themes/app_images.dart';
import '../../../../../../../themes/sizes.dart';
import '../../../../../cubits/loading_cubit/loading_cubit.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../ui/components/widgets/video_player.dart';
import '../../../../../utils/video_compressor.dart';
import '../../../../bloc/feed/feed_bloc.dart';
import '../../../../models/post_model.dart';
part 'components/add_media.dart';
part 'components/post_dialog_widget.dart';
part 'components/post_privacy.dart';
part 'constants/strings.dart';


class CreateEcobookPost extends StatefulWidget {
  const CreateEcobookPost({super.key});

  @override
  State<CreateEcobookPost> createState() => CreateEcobookPostState();
}

class CreateEcobookPostState extends State<CreateEcobookPost> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      return GestureDetector(
        onTap: _showBottomSheet,
        child: Container(
          padding: AppConstants.contentPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NameAvatar(
                data: state.usernameInitials,
              ),
              Container(
                padding: AppConstants.contentPadding,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadius),
                    color: AppColors.postBackgroundColor),
                child: Text(
                  Strings.whatToShareText,
                  style: context.textTheme.bodySmall!
                      .copyWith(color: AppColors.lowOpacityTextColor),
                ),
              ),
              Container(
                padding: AppConstants.contentPadding,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.postBackgroundColor),
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      );
    });
  }

  // Future<void> _showPostDialog() async {
  //   return showModalBottomSheet<void>(
  //     context: context,
  //     useRootNavigator: true,
  //     isScrollControlled: true,
  //     isDismissible: false,
  //     enableDrag: false,
  //     builder: (BuildContext context) {
  //       return SizedBox(
  //         height: context.viewSize.height*.80,
  //         child: const PostDialogWidget(),
  //       );
  //     },
  //   );
  // }

  Future<void> _showBottomSheet() async {
    return const PostDialogWidget().asBottomSheet(
        context,
      enableDrag: false
    );
  }
}
