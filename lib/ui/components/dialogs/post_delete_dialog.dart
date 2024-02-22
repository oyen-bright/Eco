import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:flutter/material.dart';

class ShowDeleteDialog extends StatelessWidget {
  final VoidCallback onYesPressed;

  const ShowDeleteDialog({Key? key, required this.onYesPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: AppConstants.contentPadding,
        margin: AppConstants.contentPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          color: Colors.white
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const SizedBox(width: AppSizes.size10,),
            ClipOval(child: Image.asset(AppImages.deleteAlert,
              height: context.viewSize.width*.16,
              width: context.viewSize.width*.16,),),

            const SizedBox(height: AppSizes.size10,),


            Text('Delete Post?',
              style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold
              ),),

            const SizedBox(height: AppSizes.size10,),


            Text('Are you sure you want to delete this post?\n'
                'You can’t undo this action.',
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium!.copyWith(
              ),),


            const SizedBox(height: AppSizes.size10,),

            Row(
              children: [
                Expanded(child: AppElevatedButton(
                  backgroundColor: context.colorScheme.background,
                  borderColor: context.colorScheme.primary,
                  titleColor: context.colorScheme.primary,
                  title: 'Cancel',
                  onPressed: (){
                    Navigator.pop(context);
                  },)),

                const SizedBox(width: AppSizes.size10,),

                Expanded(child: AppElevatedButton(
                  backgroundColor: context.colorScheme.primary,
                  borderColor: context.colorScheme.background,
                  title: 'Delete Post',
                  onPressed: (){
                    onYesPressed();
                    Navigator.pop(context);
                  },)),
              ],
            ).withHorViewPadding
          ],
        ),
      ),
    );
  }
}
