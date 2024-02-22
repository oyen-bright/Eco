library community_view;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/data/local_storage/local_storage.dart';
import 'package:emr_005/ecobook/views/community/community_view/components/members/member_card.dart';
import 'package:emr_005/ecomoto/views/profile/dashboard/components/header/name_avatar.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/loading_indicators/refresh_indicator.dart';
import 'package:emr_005/ui/components/widgets/shimmer.dart';
import 'package:emr_005/ui/components/wrappers/ecobook_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import '../../../../../ui/components/headers_footers/ecobook_search_bar.dart';
import '../../../bloc/community/community_bloc.dart';
import '../../../bloc/community/community_feed_model.dart';
import '../../../bloc/community/community_model.dart';
import '../components/community_post_card/community_post_card.dart';
import '../create_post/create_post_view.dart';

part 'components/community_description.dart';
part 'components/cover_image.dart';
part 'components/discuss_view.dart';
part 'components/members_view.dart';
part 'constants/strings.dart';

class CommunityView extends StatefulWidget {
  final Community community;

  const CommunityView({
    Key? key,
    required this.community,
  }) : super(key: key);

  @override
  CommunityViewState createState() => CommunityViewState();
}

class CommunityViewState extends State<CommunityView>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late final TextEditingController _searchController;
  late TabController _tabController;


  Future<void> _refreshData() async {
    print('refreshing');
  }

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EcobookWrapper(
      body: SafeArea(
        child: AppRefreshIndicator(
          onRefresh: _refreshData,
          child: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: CommunityCover(community: widget.community),
                ),
                SliverToBoxAdapter(
                  child: CommunityDescription(community: widget.community)
                      .withHorViewPadding,
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  title: _buildTabBar(context),
                ),
              ];
            },
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                DiscussView(community: widget.community),
                MembersView(community: widget.community),
                const Center(child: Text('Media')),
                const Center(child: Text('Files')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildTabBar(BuildContext context) {
    return Container(
      height: context.viewSize.width * .12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelStyle: context.textTheme.bodySmall!.copyWith(
          color: AppColors.lowOpacityTextColor,
        ),
        labelStyle: context.textTheme.titleSmall!.copyWith(
          color: AppColors.primaryAccent,
          fontWeight: FontWeight.bold,
        ),
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: context.colorScheme.primary,
              width: 4,
            ),
          ),
        ),
        isScrollable: true,
        tabAlignment: TabAlignment.center,
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 2,
        ),
        controller: _tabController,
        tabs: [
          Tab(
            child: Text(
              'Discuss',
              style: context.textTheme.bodySmall!.copyWith(),
            ),
          ),
          Tab(
            child: Text(
              'Members',
              style: context.textTheme.bodySmall!.copyWith(),
            ),
          ),
          Tab(
            child: Text(
              'Media',
              style: context.textTheme.bodySmall!.copyWith(),
            ),
          ),
          Tab(
            child: Text(
              'Files',
              style: context.textTheme.bodySmall!.copyWith(),
            ),
          ),
        ],
      ),
    );
  }
}
