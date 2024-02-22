library ecobook_profile_view;
import 'package:emr_005/ecobook/views/ecobook_profile/components/liked_posts.dart';
import 'package:emr_005/ecobook/views/ecobook_profile/components/user_posts.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/ui/components/loading_indicators/refresh_indicator.dart';
import 'package:emr_005/ui/components/wrappers/ecobook_wrapper.dart';
import 'package:flutter/material.dart';

import 'components/profile_cover.dart';

class EcobookProfileView extends StatefulWidget {

  const EcobookProfileView({
    Key? key,
  }) : super(key: key);

  @override
  EcobookProfileViewState createState() => EcobookProfileViewState();
}

class EcobookProfileViewState extends State<EcobookProfileView>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late final TextEditingController _searchController;
  late TabController _tabController;


  Future<void> _refreshData() async {}

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
                const SliverToBoxAdapter(
                  child: EcoBookProfileCover(),
                ),
                // SliverToBoxAdapter(
                //   child: CommunityDescription(community: widget.community)
                //       .withHorViewPadding,
                // ),
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
              children: const [
                UserPostView(),
                LikedPostsView(),
                Center(child: Text('Media')),
                Center(child: Text('Files')),
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
              width: 5,
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
              'Posts',
              style: context.textTheme.bodySmall!.copyWith(),
            ),
          ),
          Tab(
            child: Text(
              'Likes',
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
