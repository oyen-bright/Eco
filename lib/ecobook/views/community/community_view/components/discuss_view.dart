part of community_view;

class DiscussView extends StatefulWidget {
  final Community community;
  const DiscussView({
    super.key,
    required this.community,
  });

  @override
  DiscussViewState createState() => DiscussViewState();
}
class DiscussViewState extends State<DiscussView> {

  Future<void> _onRefresh() async {
    print('Community Id : ${widget.community.id}');
    return Future.delayed(1.seconds)
        .then((value) => context.read<CommunityBloc>().add( CommunityEvent.loadCommunityFeeds(communityId: widget.community.id!)));
  }

  @override
  void initState() {
    context.read<CommunityBloc>().add(CommunityEvent.loadCommunityFeeds(communityId: widget.community.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppRefreshIndicator(
        onRefresh: _onRefresh,
        child: Column(
          children: [

            CreateCommunityPost(community: widget.community),

              Expanded(child: SingleChildScrollView(child: BlocConsumer<CommunityBloc, CommunityState>(
                listener: (context, state) {
                  state.maybeWhen(
                    loading: (_, communityFeeds, ___) => _buildShimmerPost(context),
                    error: (message, _, communityFeeds, ___) {
                      context.showSnackBar(message);
                      _;
                      communityFeeds;
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: (_, communityFeeds, ___) => _buildShimmerPost(context),
                    orElse: () => _buildCommunityPostList(context, state.communityFeeds!),
                  );
                },
              )
            ))
          ],
        )
    );
  }

  ListView _buildCommunityPostList(BuildContext context, communityPosts) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            vertical: AppConstants.viewPaddingVertical),
        itemCount: communityPosts.length,
        itemBuilder: (buildContext, int index) {
          return CommunityPostCard(
            community: widget.community,
            communityPost: communityPosts[index],
          );
        });
  }

  Widget _buildShimmerPost(BuildContext context) {
    return AppShimmer(child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            vertical: AppConstants.viewPaddingVertical),
        itemCount: 6,
        itemBuilder: (buildContext, int index) {
          return CommunityPostCard.shimmer;
        }));
  }
}
