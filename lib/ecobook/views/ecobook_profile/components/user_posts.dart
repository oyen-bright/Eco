import 'package:emr_005/ecobook/bloc/feed/feed_bloc.dart';
import 'package:emr_005/ecobook/views/ecobook_feed/components/user_post_card/user_post_card.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/app_constants.dart';
import '../../../../ui/components/loading_indicators/refresh_indicator.dart';
import '../../../../ui/components/widgets/shimmer.dart';

class UserPostView extends StatefulWidget {
  const UserPostView({
    super.key,
  });

  @override
  UserPostViewState createState() => UserPostViewState();
}
class UserPostViewState extends State<UserPostView> {

  Future<void> _onRefresh() async {
    print('Refresh');
    return Future.delayed(1.seconds)
        .then((value) => context.read<FeedBloc>().add( const FeedEvent.loadUserFeeds()));
  }

  @override
  void initState() {
    context.read<FeedBloc>().add(const FeedEvent.loadUserFeeds());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppRefreshIndicator(
        onRefresh: _onRefresh,
        child: Column(
          children: [

            Expanded(
                child: SingleChildScrollView(
                    child:  BlocConsumer<FeedBloc, FeedState>(
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
                        return state.maybeWhen(
                          loaded: (_,feeds,__) {
                            if (feeds == null) {
                              return _buildShimmerPost(context);
                            }
                            return _buildCommunityPostList(
                                context, state.userFeeds);
                          },
                          orElse: ()=> _buildShimmerPost(context)


                        );
                      },
                    ),
            )),

          ],
        )
    );
  }

  ListView _buildCommunityPostList(BuildContext context, userFeeds) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            vertical: AppConstants.viewPaddingVertical),
        itemCount: userFeeds.length,
        itemBuilder: (buildContext, int index) {
          return UserPostCard(
            feedPost: userFeeds[index],
          );
        });
  }

  Widget _buildShimmerPost(BuildContext context,) {
    return AppShimmer(child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            vertical: AppConstants.viewPaddingVertical),
        itemCount: 5,
        itemBuilder: (buildContext, int index) {
          return UserPostCard.shimmer;
        }));
  }
}
