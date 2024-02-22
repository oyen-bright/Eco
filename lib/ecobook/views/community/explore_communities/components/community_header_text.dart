part of explore_communities;

class CommunityHeaderText extends StatelessWidget {
  const CommunityHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.viewPaddingHorizontal, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.findCommunityText,
              style: context.textTheme.titleLarge!.copyWith(),
            ),
            Text(
              Strings.findCommunityDescText,
              style: context.textTheme.bodyMedium!
                  .copyWith(color: AppColors.lowOpacityTextColor),
            ),
            const SizedBox(
              height: AppSizes.size10,
            )
          ],
        ));
  }
}
