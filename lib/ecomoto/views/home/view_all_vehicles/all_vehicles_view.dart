library view_all_vehicles;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_cubit.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/ecomoto/views/home/map_search_screen/map_search_view.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/check_button.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/cards/vehicle_card.dart';
import 'package:emr_005/ui/components/delegates/sticky_app_bar_delegate.dart';
import 'package:emr_005/ui/components/headers_footers/search_bar.dart';
import 'package:emr_005/ui/components/headers_footers/sliver_app_bar.dart';
import 'package:emr_005/ui/components/inputs/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

part 'components/vehicle_filters.dart';
part 'components/vehicle_list.dart';
part 'constants/strings.dart';

class ViewAllVehicles extends StatefulWidget {
  const ViewAllVehicles({super.key});

  @override
  ViewAllVehiclesState createState() => ViewAllVehiclesState();
}

class ViewAllVehiclesState extends State<ViewAllVehicles> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          AppSliverViewBar.flexibleSpaceBar(
            pinned: false,
            collapsedHeight: 70,
            showNotification: true,
            toolbarHeight: 40,
            floating: true,
            snap: true,
            titleSpacing: 0,
            title: context.watch<VehicleCubit>().state.isNearbyVehicles
                ? Strings.nearbyVehicleText
                : Strings.availableVehicleTest,
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: PersistentHeader(
              AppConstants.scrollUnderElevation,
              (double shrinkOffset, double elevation) =>
                  _buildSearchBar(context, shrinkOffset, elevation),
            ),
          ),
          VehicleListView(
            scrollController: scrollController,
          ),
        ],
      ),
    ));
  }

  TextSearchBar _buildSearchBar(
      BuildContext context, double shrinkOffset, double elevation) {
    final filterCount = context.watch<VehicleCubit>().state.filterCount;
    return TextSearchBar(
      onFilterPressed: () => const BrowseWithFilters().asBottomSheet(context),
      elevation: shrinkOffset > 0 ? elevation : 0.0,
      hint: Strings.searchBarHintText,
      filterCount: filterCount,
      keyboardType: TextInputType.none,
      onTap: () => const VehicleSearchMapView().asBottomSheet(context,
          expand: true,
          topSafeArea: true,
          enableDrag: false,
          bottomSafeArea: false),
    );
  }
}
