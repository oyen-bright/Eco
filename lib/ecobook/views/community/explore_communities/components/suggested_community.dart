part of explore_communities;

class SuggestedCommunities extends StatefulWidget {
  final ScrollController? scrollController;
  const SuggestedCommunities({super.key, this.scrollController,});

  @override
  SuggestedCommunitiesState createState() => SuggestedCommunitiesState();
}


class SuggestedCommunitiesState extends State<SuggestedCommunities> {

  @override
  void initState() {
    context.read<CommunityBloc>().add(const CommunityEvent.loadCommunities());
    super.initState();
  }


  @override
  Widget build(BuildContext context,) {
    return BlocConsumer<CommunityBloc, CommunityState>(
      listener: (context, state) {
        state.maybeWhen(
          loading: (communities, __, ___) => _buildShimmerCommunityGrid(context, communities),
          error: (
              message,
              communities,
              __, ___
              ) {
            context.showSnackBar('The error is here : $message');
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final List<Community> communities = state.maybeMap(
          loaded: (loadedState) => loadedState.communities,
          orElse: () => [],
        );
        final filteredCommunities = _filterCommunities(communities);

        return SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.viewPaddingGrid,
              vertical: AppConstants.viewPaddingGrid,
            ),
            sliver: state.maybeWhen(
              loading: (communities, __, ___) => _buildShimmerCommunityGrid(context, filteredCommunities),
              orElse: () => _buildSuggestedCommunities(
                context,
                filteredCommunities,
              ),
            )

        );
      },
    );
  }

  Widget _buildNoCommunitiesText() {
    return  SliverToBoxAdapter(
      child: Center(
        child: Text(
          'No communities at this moment',
          style: context.textTheme.titleMedium!.copyWith(
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestedCommunities(BuildContext context, List<Community> communities) {
    return (communities.isEmpty)
        ? _buildNoCommunitiesText()
        :  SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: context.viewSize.height * .27,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            mainAxisSpacing: 10.0),
        itemCount: communities.length,
        itemBuilder: (context, index) {
          return CommunityCard(
              community: communities[index],
              onPressed: (Community community) => AppRouter.router.go(
                  EcoBookRoutes.ecobookCommunityView,
                  extra: community)).withHorViewPadding;
        });

  }

  Widget _buildShimmerCommunityGrid(
    BuildContext context,
      communities
  ) {
    return SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: context.viewSize.height * .27,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            mainAxisSpacing: 10.0),
        itemCount: 2,
        itemBuilder: (context, index) {
          return CommunityCard.shimmer.withHorViewPadding;
        });
  }

  List<Community> _filterCommunities(List<Community> communities) {
    final userId = LocalStorage.userId;
    return communities
        .where((community) => !community.userIds.contains(userId))
        .toList();
  }
}
