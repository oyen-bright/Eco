import 'package:emr_005/ecobook/bloc/feed/feed_model.dart';
import 'package:emr_005/ecobook/views/ecobook_feed/components/user_post_card/components/user_post_content.dart';
import 'package:emr_005/ecobook/views/ecobook_feed/components/user_post_card/components/user_post_header.dart';
import 'package:emr_005/ecobook/views/ecobook_feed/components/user_post_card/components/user_post_interaction.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/feed/feed_bloc.dart';

class UserPostCard extends StatefulWidget {
  final FeedPost feedPost;

  const UserPostCard({
    Key? key,
    required this.feedPost,
  }) : super(key: key);

  static Widget get shimmer {
    return AppShimmer(
      child: UserPostCard(
        feedPost: FeedPost.dummy(),
      ),
    );
  }

  @override
  State<UserPostCard> createState() => UserPostCardState();
}

class UserPostCardState extends State<UserPostCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<FeedBloc, FeedState>
      (builder: (context, state)
    {
      return Card(
          elevation: 0.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UserPostHeader(feedPost: widget.feedPost),
              const SizedBox(height: AppSizes.size12),
              UserPostContent(feedPost: widget.feedPost),

              const SizedBox(height: AppSizes.size12),
              UserPostInteraction(feedPost: widget.feedPost,),
              const SizedBox(height: AppSizes.size12),
              Divider(
                thickness: .5,
                color: context.colorScheme.primary,
              )
            ],
          )
      );
    });

  }
}
