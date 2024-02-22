library host_view;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecomoto/cubit/host_cubit/host_cubit.dart';
import 'package:emr_005/ecomoto/cubit/trips_cubit/trip_model.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/app_text_styles.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/buttons/elevated_button.dart';
import 'package:emr_005/ui/components/delegates/sticky_app_bar_delegate.dart';
import 'package:emr_005/ui/components/headers_footers/app_tab_bar.dart';
import 'package:emr_005/ui/components/headers_footers/sliver_app_bar.dart';
import 'package:emr_005/ui/components/loading_indicators/refresh_indicator.dart';
import 'package:emr_005/ui/components/menu/app_popup_menu.dart';
import 'package:emr_005/ui/components/widgets/cached_image.dart';
import 'package:emr_005/ui/components/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'components/active_rentals.dart';
part 'components/active_vehicle.dart';
part 'components/booked_rentals.dart';
part 'components/disabled_vehicle.dart';
part 'components/empty_state.dart';
part 'components/list_vehicle_fab.dart';
part 'components/onboarding.dart';
part 'components/rental_details_tile.dart';
part 'components/vehicle_details_tile.dart';
part 'constants/strings.dart';

class HostView extends StatefulWidget {
  const HostView({super.key});

  @override
  State<HostView> createState() => _HostViewState();
}

class _HostViewState extends State<HostView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  bool showFAB = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(tabControllerListener);
  }

  @override
  void dispose() {
    _tabController.removeListener(tabControllerListener);
    _tabController.dispose();

    super.dispose();
  }

  void tabControllerListener() {
    if ([0, 1].contains(_tabController.index)) {
      if (showFAB) {
        setState(() {
          showFAB = false;
        });
      }
    } else {
      if (!showFAB) {
        setState(() {
          showFAB = true;
        });
      }
    }
  }

  bool get _hasListedVehicles {
    return context.watch<HostCubit>().hasListedVehicles;
  }

  List<String> get _tabs {
    return [
      Strings.activeRentalTabTitle,
      Strings.bookRentalTabTitle,
      Strings.activeVehicleTabTitle,
      Strings.disabledVehicleTabTitle,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          showFAB || !_hasListedVehicles ? const ListVehicleFAB() : null,
      body: SafeArea(
          child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            AppSliverViewBar.flexibleSpaceBar(
              collapsedHeight: 60,
              toolbarHeight: 60,
              pinned: false,
              showNotification: true,
              floating: true,
              snap: true,
              title: Strings.viewTitle,
            ),
            if (_hasListedVehicles)
              SliverPersistentHeader(
                pinned: true,
                delegate: PersistentHeader(
                  AppConstants.scrollUnderElevation,
                  (double shrinkOffset, double elevation) => AppTabBar(
                    elevation: shrinkOffset > 0 ? elevation : 0.0,
                    tabNames: _tabs,
                    tabController: _tabController,
                  ),
                ),
              ),
          ];
        },
        body: !_hasListedVehicles
            ? const HostOnboarding()
            : TabBarView(
                controller: _tabController,
                children: const [
                  ActiveRentals(),
                  BookedRentals(),
                  ActiveVehicles(),
                  DisabledVehicles(),
                ],
              ),
      )),
    );
  }
}
