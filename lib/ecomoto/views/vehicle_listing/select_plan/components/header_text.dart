part of '../select_plan_view.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          Strings.viewTitle,
          style: AppTextStyles.listingFormHeaderTextStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: AppSizes.size20,
        ),
        Text(
          Strings.headerText,
          style: context.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          Strings.headerTextSubtitle,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
