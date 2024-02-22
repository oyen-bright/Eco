part of community_view;

class CommunityCover extends StatelessWidget {
  final Community community;
  const CommunityCover({super.key, required this.community});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  AppImages.communityCover,
                )),
            Positioned(
                left: context.viewSize.width * .1,
                bottom: context.viewSize.width * .050,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      community.name,
                      style: context.textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.background,
                      height: .80),
                    ),
                    Text(
                      'Community Page',
                      style: context.textTheme.titleSmall!
                          .copyWith(color: context.colorScheme.background),
                    )
                  ],
                )),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              color: context.colorScheme.primary),
          child: Row(
            children: [
              Text(
                'Community created by ',
                style: context.textTheme.bodySmall!.copyWith(
                    color: context.colorScheme.background,
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                  onTap: () {},
                  child: Text(
                    (community.creatorUsername.isNotEmpty)
                        ? community.creatorUsername
                        : 'N/A',
                    style: context.textTheme.bodySmall!.copyWith(
                        color: context.colorScheme.background,
                        fontWeight: FontWeight.bold,
                        decoration: (community.creatorUsername.isNotEmpty)
                            ? TextDecoration.underline
                            : null,
                        decorationColor: context.colorScheme.background),
                  ))
            ],
          ).withContentPadded,
        )
      ],
    ).withHorViewPadding;
  }
}
