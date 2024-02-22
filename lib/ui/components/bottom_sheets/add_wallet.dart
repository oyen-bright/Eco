import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/bottom_sheets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<T?> addWalletBottomSheet<T>(BuildContext context,
    {required Widget child,
    required String title,
    void Function()? onClose,
    bool isDismissible = true}) {
  return appBottomSheet(
      // useSafeArea: true,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      isDismissible: isDismissible,
      context: context,
      builder: (context) {
        return BottomSheetWrapper(
          onClose: onClose,
          title: title,
          child: child,
        );
      });

  //   return showModalBottomSheet(
  // useSafeArea: true,
  // backgroundColor: Colors.transparent,
  // useRootNavigator: true,
  // isDismissible: isDismissible,
  // context: context,
  // builder: (context) {
  //   return BottomSheetWrapper(
  //     onClose: onClose,
  //     title: title,
  //     child: child,
  //   );
  // });
}

class BottomSheetWrapper extends StatelessWidget {
  final Widget child;
  final String title;
  final void Function()? onClose;
  const BottomSheetWrapper({
    super.key,
    required this.child,
    required this.title,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.viewPaddingHorizontal),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppConstants.borderRadius),
              topLeft: Radius.circular(AppConstants.borderRadius))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: AppSizes.size16,
                  bottom: AppSizes.size10,
                  right: AppConstants.viewPaddingHorizontal,
                  left: AppConstants.viewPaddingHorizontal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleMedium!.copyWith(
                        fontSize: context.textTheme.titleMedium!.fontSize! + 2,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () => onClose ?? context.pop(),
                      child: const Icon(Icons.close_outlined))
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          Flexible(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.viewPaddingHorizontal),
                  child: child,
                ),
              ),
            ),
          )
          // ListView(
          //   shrinkWrap: true,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.symmetric(
          //           horizontal: AppConstants.viewPaddingHorizontal),
          //       child: child,
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
