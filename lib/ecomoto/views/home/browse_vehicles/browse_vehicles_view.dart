library browse_vehicles;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_cubit.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/ecomoto/cubit/viewed_vehicle_cubit/viewed_vehicle_cubit.dart';
import 'package:emr_005/ecomoto/mixins/location_mixin.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/cards/vehicle_card.dart';
import 'package:emr_005/ui/components/delegates/sticky_app_bar_delegate.dart';
import 'package:emr_005/ui/components/headers_footers/grid_list_header.dart';
import 'package:emr_005/ui/components/headers_footers/search_bar.dart';
import 'package:emr_005/ui/components/headers_footers/sliver_app_bar.dart';
import 'package:emr_005/ui/components/inputs/star_rating.dart';
import 'package:emr_005/ui/components/loading_indicators/refresh_indicator.dart';
import 'package:emr_005/ui/components/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../map_search_screen/map_search_view.dart';

part 'components/browse_search_bar.dart';
part 'components/nearby_vehicles.dart';
part 'components/recently_viewed_vehicles.dart';
part 'components/top_dealers.dart';
part 'constants/strings.dart';

class BrowseVehiclesView extends StatefulWidget {
  const BrowseVehiclesView({super.key});

  @override
  State<BrowseVehiclesView> createState() => _BrowseVehiclesViewState();
}

class _BrowseVehiclesViewState extends State<BrowseVehiclesView>
    with LocationMixin {
  late final ScrollController scrollController;
  bool hasRequestedPermission = false;

  @override
  void initState() {
    requestPermission();
    super.initState();
    scrollController = ScrollController();
  }

  Future<void> _refreshData() async {
    return Future.delayed(1.seconds)
        .then((value) => context.read<VehicleCubit>().getAllVehicle());
  }

  void requestPermission() async {
    if (!hasRequestedPermission) {
      await requestLocationPermission(context);
      setState(() {
        hasRequestedPermission = true;
      });
    } else {
      requestLocationPermission(context);
    }
  }

  @override
  void didChangeDependencies() {
    requestPermission();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !hasRequestedPermission
        ? const SizedBox.shrink()
        : Scaffold(
            body: SafeArea(
              child: AppRefreshIndicator(
                onRefresh: _refreshData,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: scrollController,
                  slivers: [
                    AppSliverViewBar.flexibleSpaceBar(
                      collapsedHeight: 60,
                      toolbarHeight: 60,
                      pinned: false,
                      floating: true,
                      snap: true,
                      showNotification: true,
                      title: Strings.browseVehiclesText,
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: PersistentHeader(
                        AppConstants.scrollUnderElevation,
                        (double shrinkOffset, double elevation) =>
                            ContainerSearchBar(
                          elevation: shrinkOffset > 0 ? elevation : 0.0,
                          hint: Strings.searchBoxText,
                          onTap: () => const VehicleSearchMapView()
                              .asBottomSheet(context,
                                  expand: true,
                                  topSafeArea: true,
                                  enableDrag: false,
                                  bottomSafeArea: false),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: AppSizes.size10,
                          ),
                          const NearbyVehicles(),
                          const SizedBox(
                            height: AppSizes.size10,
                          ),
                          TopVehicleDealers(),
                          const SizedBox(
                            height: AppSizes.size10,
                          ),
                          const RecentlyViewedVehicles(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
