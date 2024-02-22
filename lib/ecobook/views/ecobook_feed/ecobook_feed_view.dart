library feed_view;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/ecobook/bloc/feed/feed_bloc.dart';
import 'package:emr_005/ecobook/views/ecobook_feed/components/user_post_card/user_post_card.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/ui/components/loading_indicators/refresh_indicator.dart';
import 'package:emr_005/ui/components/wrappers/ecobook_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/feed/feed_model.dart';
import 'components/create_post/create_post_view.dart';

part 'components/feed_list.dart';

class EcobookFeedView extends StatefulWidget {
  const EcobookFeedView({Key? key}) : super(key: key);

  @override
  State<EcobookFeedView> createState() => EcobookFeedViewState();
}

class EcobookFeedViewState extends State<EcobookFeedView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshData() async {
    return Future.delayed(1.seconds)
        .then((value) => context.read<FeedBloc>().add(const FeedEvent.loadFeeds()));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EcobookWrapper(
        body: SafeArea(
      child: AppRefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            const SliverToBoxAdapter(
              child: CreateEcobookPost(),
            ),

            FeedListView(
              scrollController: scrollController,
            ),


            // SliverToBoxAdapter(child:ElevatedButton(onPressed: _refreshData, child: Text('Helo'))
            //   ,)
          ],
        ),
      ),
    ));
  }
}
