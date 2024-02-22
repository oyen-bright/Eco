import 'package:aiprise_flutter_sdk/aiprise_flutter_sdk.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_environment.dart';
import 'package:emr_005/data/local_storage/local_storage.dart';
import 'package:emr_005/extensions/color.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerifyIdentificationDialog extends StatelessWidget {
  final dynamic Function(String?)? onStart;
  final dynamic Function(String?)? onAbandoned;
  final dynamic Function(String?)? onSuccess;
  final dynamic Function(String?)? onComplete;
  final dynamic Function()? onError;

  const VerifyIdentificationDialog({
    Key? key,
    this.onStart,
    this.onAbandoned,
    this.onSuccess,
    this.onComplete,
    this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.size10, vertical: AppSizes.size10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton.outlined(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.close_outlined)),
        ),
        Expanded(
          child: AiPriseFrame(
            theme: AiPriseThemeOptions(
                font_name: "poppins",
                color_brand: context.colorScheme.primary.toHex,
                background: context.theme.brightness == Brightness.light
                    ? "light"
                    : "dark"),
            clientReferenceID: LocalStorage.userId,
            mode: AppEnvironment.aiPrice.mode,
            templateID: AppEnvironment.aiPrice.templateID,
            onStart: onStart,
            // onAbandoned: onAbandoned,
            // onSuccess: (sessionId) {
            //   context.pop((sessionId: sessionId));
            // },
            onComplete: (sessionId) {
              context.pop((sessionId: sessionId));
            },
            onError: () {
              context.showSnackBar(AppConstants.appErrorMessage, BarType.error);
              context.pop();
            },
          ),
        ),
        const SizedBox(
          height: AppSizes.size10,
        )
      ]),
    );
  }
}
