part of community_view;


class CommunityDescription extends StatefulWidget {
  final Community community;
  const CommunityDescription({super.key, required this.community});

  @override
  CommunityDescriptionState createState() => CommunityDescriptionState();
}

class CommunityDescriptionState extends State<CommunityDescription> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSizes.size6,
        ),
        Text(
          '${widget.community.name} Community',
          style: context.textTheme.titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: AppSizes.size6,
        ),
        _infoRow(context),
        const SizedBox(
          height: AppSizes.size6,
        ),
        _aboutBox(context)
      ],
    );
  }

  Container _aboutBox(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.postBackgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'About Community',
            style: context.textTheme.titleSmall!
                .copyWith(color: AppColors.lowOpacityTextColor),
          ),
          ReadMoreText(
            '${widget.community.description}',
            trimLines: 4,
            textAlign: TextAlign.justify,
            trimMode: TrimMode.Line,
            trimCollapsedText: " Show More",
            moreStyle: context.textTheme.bodySmall!.copyWith(
              color: AppColors.hyperLinkColor,
            ),
            trimExpandedText: " Show less",
            lessStyle: context.textTheme.bodySmall!.copyWith(
              color: AppColors.hyperLinkColor,
            ),
            style: context.textTheme.bodySmall!.copyWith(),
          )
        ],
      ),
    );
  }

  Row _infoRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Wrap(
              spacing: context.viewSize.width * -.050,
              children: List.generate(
                widget.community.username.take(4).length,
                (index) {
                  final username = widget.community.username[index];
                  return NameAvatar(data: AppConstants.getUsernameInitials(username));
                },
              ),
            ),
            const SizedBox(
              width: AppSizes.size8,
            ),
            AutoSizeText(
              widget.community.username.length > 1
                  ? '${widget.community.username.length} Members'
                  : '${widget.community.username.length} Member',
              style: context.textTheme.bodyMedium!.copyWith(
                  color: context.colorScheme.onBackground, letterSpacing: -0.8),
              minFontSize: 10,
            )
          ],
        ),
        Row(
          children: [
            (widget.community.userIds.contains(LocalStorage.userId))
            ? TextButton(onPressed: (){},
                child: const Text('Joined'))

            : AppElevatedButton.small(
              borderRadius: BorderRadius.circular(8),
              title: 'Join',
              onPressed: () {
                print(LocalStorage.userId);
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Transform.scale(
              scaleX: .85,
              child: AppElevatedButton.small(
                borderRadius: BorderRadius.circular(8),
                onPressed: () {},
                title: '',
                child: Icon(
                  Icons.people_sharp,
                  color: context.colorScheme.background,
                ),
              ),
            )
          ],
        )
      ],
    );
  }

}
