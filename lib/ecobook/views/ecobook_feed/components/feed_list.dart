part of feed_view;

class FeedListView extends StatefulWidget {
  final ScrollController? scrollController;

  const FeedListView({Key? key, this.scrollController}) : super(key: key);

  @override
  State<FeedListView> createState() => FeedListViewState();
}

class FeedListViewState extends State<FeedListView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (
            message,
            feeds,
          ) {
            context.showSnackBar('The error is here : $message');
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.viewPaddingGrid,
            vertical: AppConstants.viewPaddingGrid,
          ),
          sliver: state.maybeWhen(
            loading: (List<FeedPost>? feeds) =>
                _buildShimmerGrid(context, feeds),
            orElse: () => _buildFeedList(
              context,
              state.maybeMap(
                error: (errorState) => errorState.feeds ?? [],
                loaded: (loadedState) => loadedState.feeds,
                orElse: () => [],
              ),
            ),
          ),
        );
      },
    );
  }

  SliverList _buildFeedList(BuildContext context, feeds) {
    return SliverList.builder(
      itemCount: feeds.length,
      itemBuilder: (BuildContext context, int index) {
        return UserPostCard(
          feedPost: feeds[index],
        );
      },
    );
  }

  Widget _buildShimmerGrid(
    BuildContext context, feeds
  ) {
    return SliverList.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return UserPostCard.shimmer;
      },
    );
  }
}
