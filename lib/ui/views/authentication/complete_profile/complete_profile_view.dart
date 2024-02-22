library complete_profile;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecomoto/mixins/validation_mixin.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/inputs/text_field_input.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../router/app_router.dart';
import '../../../../../../themes/app_colors.dart';
import '../../../../ui/components/wrappers/auth_view_wrapper.dart';

part 'components/form_header_text.dart';
part 'components/register_user_form.dart';
part 'constants/strings.dart';

class CompleteProfileView extends StatelessWidget {
  const CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthViewWrapper(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: AppConstants.viewPaddingHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormHeaderText(),
              SizedBox(
                height: AppSizes.size20,
              ),
              RegisterUserForm()
            ],
          ),
        ),
      ),
    );
  }
}
