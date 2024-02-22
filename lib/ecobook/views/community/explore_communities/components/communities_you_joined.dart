part of explore_communities;

class JoinedCommunities extends StatefulWidget {
  final ScrollController scrollController;
  const JoinedCommunities(
      {super.key, required this.scrollController});

  @override
  JoinedCommunitiesState createState() => JoinedCommunitiesState();
}

class JoinedCommunitiesState extends State<JoinedCommunities> {
  @override
  void initState() {
    context.read<CommunityBloc>().add(const CommunityEvent.loadCommunities());
    super.initState();
  }


  @override

  Widget build(BuildContext context) {
    return BlocConsumer<CommunityBloc, CommunityState>(
      listener: (context, state) {
        state.maybeWhen(
          loading: (communities, __, ___) => _buildShimmerList(context, communities),
          error: (
              message,
              communities, __, ___
              ) {
            context.showSnackBar('The error is here : $message');
          },
          orElse: () {},
        );
      },

      builder: (context, state) {
        final List<Community> communities = state.maybeMap(
          loaded: (loadedState) => loadedState.communityData,
          orElse: () => [],
        );
        final filteredCommunities = _filterCommunities(communities);

        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  color: AppColors.searchBarColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    filteredCommunities.isNotEmpty ? 'COMMUNITIES YOU\'HAVE JOINED'
                  : 'NO COMMUNITIES JOINED',
                    style: context.textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.lowOpacityTextColor),
                  ),
                  IconButton(onPressed: () {
                    final  communityInput = CommunityInput();
                    AppRouter.router
                        .go(EcoBookRoutes.createCommunityView, extra: communityInput);
                  }, icon: const Icon(Icons.add))
                ],
              ).withHorViewPadding,
            ).withHorViewPadding,
            state.maybeWhen(
              loading: (communities, __, ___) => _buildShimmerList(context, communities),
              orElse: () => _buildJoinedCommunitiesList(
                context,
                filteredCommunities,
              ),
            )

          ],
        );

      },
    );
  }



  ListView _buildJoinedCommunitiesList (BuildContext context, communities) {
    return ListView.builder(
      shrinkWrap: true,
      controller: widget.scrollController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: communities.length,
      itemBuilder: (buildContext, int index) {
        return CommunityList(
          community: communities[index],
          onPressed: (Community community) => AppRouter.router
              .push(EcoBookRoutes.ecobookCommunityView, extra: community),
        );
      },
    );

  }

  Widget _buildShimmerList (BuildContext context, communities) {
    return AppShimmer(child: ListView.builder(
      shrinkWrap: true,
      controller: widget.scrollController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (buildContext, int index) {
        return CommunityList.shimmer.withHorViewPadding;
      },
    ));

  }

  List<Community> _filterCommunities(List<Community> communities) {
    final userId = LocalStorage.userId;
    return communities
        .where((community) => community.userIds.contains(userId))
        .toList();
  }
}

class CommunityList extends StatefulWidget {
  final Community community;
  final void Function(Community)? onPressed;
  const CommunityList({
    Key? key,
    required this.community,
    this.onPressed,
  }) : super(key: key);

  static Widget get shimmer {
    return AppShimmer(
      child: CommunityList(
        community: Community.dummy(),
      ),
    );
  }
  @override
  State<CommunityList> createState() => CommunityListState();
}

class CommunityListState extends State<CommunityList> {
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          onTap: () {
            if (widget.onPressed != null) {
              widget.onPressed!(widget.community);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Container(
                      width: context.viewSize.width*.14,
                      height: context.viewSize.width*.14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.colorScheme.onBackground,
                          width: 1.0,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: context.viewSize.width*.07,
                        backgroundColor: Colors.transparent,
                        backgroundImage: (widget.community.communityDp != null &&
                            widget.community.communityDp!.isNotEmpty)
                            ? NetworkImage("https://gateway.pinata.cloud/ipfs/${widget.community.communityDp!}")
                            : null,
                        child: (widget.community.communityDp != null &&
                            widget.community.communityDp!.isNotEmpty)
                            ? null
                            : const Text('NA', style: TextStyle(color: Colors.red)),
                      ),
                    ),
                  )
                  ,
                  const SizedBox(
                    width: AppSizes.size6,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.community.name,
                        style: context.textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.community.username.length > 1
                            ? '${widget.community.username.length} members'
                            : '${widget.community.username.length} member',
                        style: context.textTheme.bodyMedium!
                            .copyWith(color: AppColors.lowOpacityTextColor),
                      )
                    ],
                  )
                ],
              ),
              // IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
              _MorePopUpMenu(widget.community)
            ],
          ).withHorViewPadding,
        ));
  }

}

class _MorePopUpMenu extends StatelessWidget {
  final Community community;

  const _MorePopUpMenu(this.community);

  @override
  Widget build(BuildContext context) {
    final options = community.userIds.first == LocalStorage.userId
        ? 
        [
          ('view', 'View', null),
          ('leave', 'Leave', Colors.red),
        ]
    
        : null;

    return SizedBox(
      height: 20,
      child: PopupMenuButton<String>(
        offset: const Offset(-5, 20),
        padding: EdgeInsets.zero,
        elevation: 1,
        itemBuilder: (context) {
          return options!.map(
                (e) => PopupMenuItem<String>(
              height: kMinInteractiveDimension - 5,
              value: e.$1,
              child: Text(
                e.$2,
                style: context.textTheme.labelLarge?.copyWith(color: e.$3),
              ),
            ),
          )
              .toList();
        },
        onSelected: (value) {
          if (value == "view") {
            print('view');
          }

          if (value == "leave") {
            print('Leave Pressed');
          }

          
          
        },
      ),
    );
  }
  
}

