part of register_account;

class TermsAndPolicyButton extends StatelessWidget {
  const TermsAndPolicyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(Strings.byContinuingText),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                //TODO: terms of use
              },
              child: Text(Strings.termsOfUseText,
                  style: context.textTheme.titleSmall!
                      .copyWith(color: AppColors.hyperLinkColor)),
            ),
            const SizedBox(
              width: AppSizes.size4,
            ),
            Text(
              Strings.andText,
              style: context.textTheme.titleSmall,
            ),
            const SizedBox(
              width: AppSizes.size4,
            ),
            GestureDetector(
              onTap: () {
                //TODO: privacy policy
              },
              child: Text(Strings.privacyPolicyText,
                  style: context.textTheme.titleSmall!
                      .copyWith(color: AppColors.hyperLinkColor)),
            ),
          ],
        )
      ],
    );
  }
}
