part of email_verification;

class TermsAndPolicy extends StatelessWidget {
  const TermsAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: AppSizes.size20,
        ),
        Text(
          Strings.emailSentByEcomoto,
          style: context.textTheme.bodySmall,
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                Strings.termsAndConditionsText,
                style: context.textTheme.bodySmall?.copyWith(
                    // color: AppColors.hyperLinkColor,
                    decoration: TextDecoration.underline),
              ),
            ),
            Container(
              height: AppSizes.size4,
              width: AppSizes.size4,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorScheme.onBackground),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                Strings.privacyPolicyText,
                style: context.textTheme.bodySmall?.copyWith(
                    // color: AppColors.hyperLinkColor,
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        )
      ],
    );
  }
}
