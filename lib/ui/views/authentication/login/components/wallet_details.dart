import 'package:auto_size_text/auto_size_text.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/display/dashed_lines.dart';
import 'package:emr_005/utils/clipboard_utils.dart';
import 'package:emr_005/utils/save_file.dart';
import 'package:emr_005/utils/share.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class WalletDetails extends StatelessWidget {
  final Map<String, dynamic> walletDetails;
  const WalletDetails({super.key, required this.walletDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.viewPaddingHorizontal),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                controller: ModalScrollController.of(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: AppSizes.size20,
                    ),
                    const AutoSizeText(
                      "Your wallet was generated successfully",
                      style: AppTextStyles.authSectionHeader2TextStyle,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: AppSizes.size10,
                    ),
                    AutoSizeText(
                      "You can can copy your wallet details below and say it in a safe place. You can use the private key to access you wallet on any wallet provider.",
                      style: context.textTheme.bodySmall,
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: AppSizes.size10,
                    ),
                    _WalletDetailCard(
                        data: walletDetails['publicKey'],
                        title: "Wallet Address"),
                    const SizedBox(
                      height: AppSizes.size10,
                    ),
                    _WalletDetailCard(
                        data: walletDetails['privateKey'],
                        title: "Private Key"),
                    const SizedBox(
                      height: AppSizes.size10,
                    ),
                    _WalletDetailCard(
                        data: (walletDetails['mnemonic'].toString().split(' ')),
                        title: "Mnemonic"),
                    const SizedBox(
                      height: AppSizes.size10,
                    ),
                    TextButton.icon(
                        onPressed: () {
                          final walletDetailString = walletDetails.entries
                              .map((entry) => "${entry.key}: ${entry.value}")
                              .join('\n');

                          saveFile(walletDetailString,
                                  fileNameWithExtention: "wallet_details.txt")
                              .then((value) {
                            shareFile(
                              context,
                              filePath: value.filePath!,
                              subject: "",
                              text: "",
                            );
                          });
                        },
                        icon: const Icon(Icons.download),
                        label: const Text("Download Wallet File")),
                    const SizedBox(
                      height: AppSizes.size10,
                    ),
                  ],
                ),
              ),
            ),
            AppElevatedButton(
              title: "Continue",
              onPressed: () => AppRouter.router.pop(),
            ),
            const SizedBox(
              height: AppSizes.size10,
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletDetailCard extends StatefulWidget {
  final String title;
  final Object data;

  const _WalletDetailCard({required this.title, required this.data});

  @override
  State<_WalletDetailCard> createState() => _WalletDetailCardState();
}

class _WalletDetailCardState extends State<_WalletDetailCard> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: Text(
              widget.title,
              style: context.textTheme.titleLarge?.copyWith(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            )),
            TextButton.icon(
                style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact),
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: Icon(
                  isVisible ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                ),
                label: Text(isVisible ? 'Hide' : 'Reveal'))
          ],
        ),
        const SizedBox(
          height: AppSizes.size6,
        ),
        if (widget.data is List)
          Wrap(
            spacing: AppSizes.size10,
            children: (widget.data as List)
                .map((e) => Chip(
                      label: Text(
                          isVisible ? e.toString() : '*' * e.toString().length),
                      shape: const RoundedRectangleBorder(),
                      visualDensity: VisualDensity.compact,
                    ))
                .toList(),
          )
        else
          AutoSizeText(isVisible
              ? widget.data.toString()
              : '*' * widget.data.toString().length),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Expanded(
                child: DashedDivider(
              dashWidth: 6,
              height: 0.1,
            )),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                  style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact),
                  onPressed: () {
                    if (widget.data is List) {
                      print((widget.data as List).join(" "));
                      copyToClipboard(context, (widget.data as List).join());
                    } else {
                      copyToClipboard(context, widget.data.toString());
                    }
                  },
                  icon: const Icon(
                    Icons.copy,
                    size: 20,
                  ),
                  label: const Text('copy to clipboard')),
            ),
          ],
        )
      ],
    );
  }
}
