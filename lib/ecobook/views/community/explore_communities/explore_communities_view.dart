library explore_communities;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/ecobook/bloc/community/community_bloc.dart';
import 'package:emr_005/ecobook/bloc/community/community_model.dart';
import 'package:emr_005/ecobook/models/create_community.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/ui/components/delegates/sticky_app_bar_delegate.dart';
import 'package:emr_005/ui/components/loading_indicators/refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emr_005/data/local_storage/local_storage.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/widgets/shimmer.dart';
import '../../../../../../config/app_routes.dart';
import '../../../../../../router/app_router.dart';
import '../../../../ui/components/headers_footers/ecobook_search_bar.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
part 'components/communities_you_joined.dart';
part 'components/community_card.dart';
part 'components/community_header_text.dart';
part 'components/suggested_community.dart';
part 'constants/strings.dart';

class ExploreCommunitiesView extends StatefulWidget {
  const ExploreCommunitiesView({super.key});

  @override
  ExploreCommunitiesViewState createState() => ExploreCommunitiesViewState();


}

class ExploreCommunitiesViewState extends State<ExploreCommunitiesView> {

  final ScrollController scrollController = ScrollController();
  late final TextEditingController _searchController;

  Future<void> _refreshData() async {
    context.read<CommunityBloc>().add(const CommunityEvent.loadCommunities());
  }



  @override
  void initState() {
    print("reintiliazed");
    _searchController = TextEditingController();
    context.read<CommunityBloc>().add(const CommunityEvent.loadCommunities());
    super.initState();
  }



  @override
  void dispose() {
    print("disposed");
    scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: AppRefreshIndicator(
                onRefresh: _refreshData,
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: PersistentHeader(
                        AppConstants.scrollUnderElevation,
                            (double shrinkOffset, double elevation) =>
                            _buildSearchBar(context, shrinkOffset, elevation),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: CommunityHeaderText(),
                    ),
                    SliverToBoxAdapter(
                      child:
                      JoinedCommunities(scrollController: scrollController),
                    ),
                    SliverToBoxAdapter(
                        child: Text(
                          'Suggested Communities',
                          style: context.textTheme.titleLarge!.copyWith(),
                        ).withViewPadding),


                    SuggestedCommunities(scrollController: scrollController),
                    SliverToBoxAdapter(
                      child: AppElevatedButton(
                        onPressed: _refreshData,
                        title: 'G',
                      ),
                    )
                  ],
                ))));
  }

  EcobookSearchBar _buildSearchBar(
      BuildContext context, double shrinkOffset, double elevation) {
    return EcobookSearchBar(
      elevation: shrinkOffset > 0 ? elevation : 0.0,
      hint: Strings.exploreCommunityHintText,
      controller: _searchController,
      // Todo : add on tap callback
    );
  }
}
