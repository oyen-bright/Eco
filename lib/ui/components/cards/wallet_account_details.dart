import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/ecomoto/mixins/wallet_mixin.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';

class WalletAccountDetails extends StatelessWidget with WalletUtils {
  final String walletAddress;
  const WalletAccountDetails({super.key, required this.walletAddress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.size10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(color: AppColors.lightGreyColor)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: AppSizes.size20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.size2,
            ),
            child: Row(
              children: [
                Image.asset(
                  AppImages.walletAccountIcon,
                  scale: 1.5,
                ),
                const SizedBox(
                  width: AppSizes.size16,
                ),
                Expanded(
                    child: Text(
                  formatAddress(walletAddress),
                  style: context.textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                  maxLines: 1,
                ))
              ],
            ),
          ),
          const SizedBox(
            height: AppSizes.size12,
          ),
          Row(
            children: [
              Expanded(
                  child: ListTile(
                contentPadding: EdgeInsets.zero,
                titleTextStyle: context.textTheme.bodySmall,
                horizontalTitleGap: -14,
                leading: Image.asset(
                  AppImages.copyIcon,
                  scale: 1.7,
                  color: AppColors.darkGreyColor,
                ),
                title: const Text("Copy address"),
              )),
              Expanded(
                  child: ListTile(
                titleTextStyle: context.textTheme.bodySmall!.copyWith(),
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: -11,
                leading: Image.asset(
                  AppImages.viewIcon,
                  color: AppColors.darkGreyColor,
                  scale: 1.7,
                ),
                title: const Text("View on Explorer"),
              )),
            ],
          ),
          const SizedBox(
            height: AppSizes.size6,
          ),
        ],
      ),
    );
  }
}
