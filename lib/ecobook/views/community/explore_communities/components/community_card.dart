part of explore_communities;


class CommunityCard extends StatelessWidget {
  final Community community;
  final void Function(Community)? onPressed;

  const CommunityCard(
      {Key? key, required this.community, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed!(community);
        }
      },
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SizedBox(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppConstants.borderRadius),
                    topRight: Radius.circular(AppConstants.borderRadius),
                  ),
                  child: (community.communityDp != null &&
                          community.communityDp!.isNotEmpty)
                      ? Image.network(
                    "https://gateway.pinata.cloud/ipfs/${community.communityDp!}",
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          AppImages.noVehicleImage,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSizes.size4,
            ),
            AutoSizeText(
              community.name,
              style: context.textTheme.titleSmall!.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,),
              minFontSize: 8,
              maxLines: 1,
              maxFontSize: 14,
            ),
            if (community.description != null)
              Text(
                community.description!,
                style: context.textTheme.labelSmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.circle,
                      size: 10,
                      color: Color(0xFF23A559),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      '1 Online',
                      style:
                          context.textTheme.bodySmall!.copyWith(fontSize: 10),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.circle,
                      color: Colors.grey,
                      size: 10,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      community.username.length > 1
                          ? '${community.username.length} members'
                          : '${community.username.length} member',
                      style:
                          context.textTheme.bodySmall!.copyWith(fontSize: 10),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            AppElevatedButton.small(
              onPressed: onPressed != null ? () => onPressed!(community) : null,
              title: 'View Community',
            ),
          ],
        ),
      ),
    );
  }

  static Widget get shimmer {
    return AppShimmer(
      child: CommunityCard(
        community: Community.dummy(),
        onPressed: null,
      ),
    );
  }
}
