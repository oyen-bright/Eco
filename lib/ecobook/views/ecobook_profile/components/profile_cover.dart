import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/ecomoto/views/profile/dashboard/components/header/name_avatar.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/user_cubit/user_cubit.dart';

class EcoBookProfileCover extends StatelessWidget {
  const EcoBookProfileCover({super.key});




  @override
  Widget build(BuildContext context) {


    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Container(
          padding: AppConstants.contentPadding,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              color: AppColors.postBackgroundColor
          ),
          child: Column(
            children: [
              Row(
                children: [


                  NameAvatar(
                    customRadius: 25,
                      data: state.usernameInitials,
                    fontSize: 26,
                  ),
                  const SizedBox(width: 6,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${state.user.firstName} ${state.user.lastName}',
                      style: context.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,

                      ),),
                      Text("(${state.user.username})"),


                      // NameText(
                      //     data: state.when<String>(
                      //       details: (user) => user.username,
                      //     ),
                      //     color: context.colorScheme.primary)
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10,),
              Row(children: [
                Expanded(child: AppElevatedButton.small(
                  onPressed: (){},
                title: 'Edit Profile',)),

                const SizedBox(width: 5,),

                Expanded(child: AppElevatedButton.small(
                  onPressed: (){},
                  title: 'Ads',))
              ],)
            ],
          ),
        );

      },
    );
  }
}
