library trips;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecomoto/cubit/trips_cubit/trip_model.dart';
import 'package:emr_005/ecomoto/cubit/trips_cubit/trips_cubit.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_cubit.dart';
import 'package:emr_005/ecomoto/mixins/location_mixin.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/services/ecomoto/location_service.dart';
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
import 'package:emr_005/utils/clipboard_utils.dart';
import 'package:emr_005/utils/difference_in_days.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:emr_005/utils/haptic_utils.dart';
import 'package:emr_005/utils/km_miles_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

part 'components/active.dart';
part 'components/booked.dart';
part 'components/find_a_vehicle_fab.dart';
part 'components/history.dart';
part 'components/no_trips.dart';
part 'components/trip_details.dart';
part 'components/trip_details_tile.dart';
part 'constants/constants.dart';
part 'constants/strings.dart';

class TripsView extends StatefulWidget {
  const TripsView({Key? key}) : super(key: key);

  @override
  State<TripsView> createState() => _TripsViewState();
}

class _TripsViewState extends State<TripsView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _scrollController;

  Future<void> _refreshData() async {
    // return context.read<VehicleCubit>().getAllVehicle();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: context.watch<TripsCubit>().state.isEmptyData
          ? const FindVehicleFAB()
          : const SizedBox.shrink(),
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
              SliverPersistentHeader(
                pinned: true,
                delegate: PersistentHeader(
                  AppConstants.scrollUnderElevation,
                  (double shrinkOffset, double elevation) => AppTabBar(
                    elevation: shrinkOffset > 0 ? elevation : 0.0,
                    tabNames: const [
                      Strings.activeTabTitle,
                      Strings.bookedTabTitle,
                      Strings.historyTabTitle
                    ],
                    tabController: _tabController,
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              const Active(),
              const Booked(),
              History(
                scrollController: _scrollController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class AppTabBar extends StatelessWidget {
//   const AppTabBar({
//     super.key,
//     required TabController tabController,
//   }) : _tabController = tabController;

//   final TabController _tabController;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: context.colorScheme.secondary,
//       width: double.infinity,
//       height: kToolbarHeight,
//       child: Row(
//         children: [
//           Expanded(
//             child: Align(
//               alignment: Alignment.centerRight,
//               child: InkWell(
//                 onTap: () => _tabController.animateTo(1),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: AppSizes.size10),
//                   child: Column(mainAxisSize: MainAxisSize.max, children: [
//                     const Spacer(),
//                     Text(
//                       "Booked",
//                       style: context.theme.tabBarTheme.labelStyle!,
//                     ),
//                     const SizedBox(
//                       height: AppSizes.size4,
//                     ),
//                     Container(
//                       width: 58,
//                       height: 4,
//                       decoration: const ShapeDecoration(
//                         color: Color(0xFF215759),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(4),
//                             topRight: Radius.circular(4),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Spacer(),
//                   ]),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Material(
//               color: Colors.transparent,
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: InkWell(
//                   onTap: () => _tabController.animateTo(1),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: AppSizes.size10),
//                     child: Column(mainAxisSize: MainAxisSize.max, children: [
//                       const Spacer(),
//                       Text(
//                         "History",
//                         style: context.theme.tabBarTheme.labelStyle!,
//                       ),
//                       const SizedBox(
//                         height: AppSizes.size4,
//                       ),
//                       Container(
//                         width: 58,
//                         height: 5,
//                         decoration: const ShapeDecoration(
//                           color: Color(0xFF215759),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(4),
//                               topRight: Radius.circular(4),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const Spacer(),
//                     ]),
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
