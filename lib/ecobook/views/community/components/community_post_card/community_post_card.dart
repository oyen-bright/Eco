import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import '../../../../bloc/community/community_feed_model.dart';
import '../../../../bloc/community/community_model.dart';
import 'components/community_post_content.dart';
import 'components/community_post_header.dart';
import 'components/community_post_interaction.dart';

class CommunityPostCard extends StatefulWidget {
  final CommunityPost communityPost;
  final Community community;

  const CommunityPostCard({
    Key? key, required this.communityPost, required this.community,
  }) : super(key: key);

  static Widget get shimmer {
    return AppShimmer(
      child: CommunityPostCard(
        community: Community.dummy(),
        communityPost: CommunityPost.dummy(),
      ),
    );
  }
  @override
  State<CommunityPostCard> createState() => CommunityPostCardState();

}

class CommunityPostCardState extends State<CommunityPostCard> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CommunityPostHeader(
            community: widget.community,
              communityPost: widget.communityPost),
          const SizedBox(height: AppSizes.size12),
          CommunityPostContent(communityPost: widget.communityPost),

          const SizedBox(height: AppSizes.size12),
          CommunityPostInteraction(communityPost: widget.communityPost, community: widget.community,),
          const SizedBox(height: AppSizes.size12),
          Divider(
            thickness: .5,
            color: context.colorScheme.primary,
          )
        ],
      )
    );
  }



}
