import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ui/components/dialogs/id_verification_dialog.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin AiPrice {
  verifyDriversLicense(BuildContext context) async {
    final response = await const VerifyIdentificationDialog()
        .asDialog<({String sessionId})?>(context);

    if (response != null && context.mounted) {
      final updateResponse = await context
          .read<UserCubit>()
          .updateUserDriverKYC(sessionId: response.sessionId);

      if (updateResponse.error != null) {
        context.mounted ? context.showSnackBar(updateResponse.error) : null;
        return;
      }
      return;
    }
  }
}
