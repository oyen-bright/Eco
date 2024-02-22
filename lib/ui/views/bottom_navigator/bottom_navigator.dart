library app_bottom_navigator;

import 'package:emr_005/controllers/app_scaffold_controller.dart';
import 'package:emr_005/ecomoto/cubit/trips_cubit/trips_cubit.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:emr_005/ui/components/display/smart_car_controls.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:emr_005/utils/haptic_utils.dart';
import 'package:emr_005/utils/orientation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../components/drawers/profile_drawer/dashboard_drawer.dart';

part 'components/bottom_navigator_icon.dart';
part 'components/custom_bottom_navigator.dart';
part 'components/custom_navigation_bar_item.dart';
part 'constants/constants.dart';
part 'constants/strings.dart';

class AppBottomNavigator extends StatefulWidget {
  const AppBottomNavigator({
    super.key,
    required this.child,
  });

  final StatefulNavigationShell child;

  @override
  State<AppBottomNavigator> createState() => _AppBottomNavigatorState();
}

class _AppBottomNavigatorState extends State<AppBottomNavigator> {
  @override
  void initState() {
    super.initState();
    setPortraitOrientation();
  }

  @override
  void dispose() {
    resetPreferredOrientations();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showEcobook = widget.child.currentIndex > 4;
    final ecomoto = <({
      int index,
      Color? backgroundColor,
      String icon,
      bool isSwitcher,
      String label,
      int? notificationCount,
    })>[
      (
        index: 0,
        icon: AppImages.homeIcon,
        label: Strings.homeMenu,
        isSwitcher: false,
        backgroundColor: null,
        notificationCount: null
      ),
      (
        index: 1,
        icon: AppImages.categoryIcon,
        label: Strings.tripsMenu,
        isSwitcher: false,
        backgroundColor: null,
        notificationCount: null
      ),
      (
        index: 2,
        icon: AppImages.communityIcon,
        label: Strings.ecoBookMenu,
        isSwitcher: true,
        backgroundColor: AppColors.ecobookSwitcherColor,
        notificationCount: null
      ),
      (
        index: 3,
        icon: AppImages.hostIcon,
        label: Strings.hostMenu,
        isSwitcher: false,
        backgroundColor: null,
        notificationCount: null
      ),
      (
        index: 4,
        icon: AppImages.profileIcon,
        label: Strings.profileMenu,
        isSwitcher: false,
        backgroundColor: null,
        notificationCount: null
      )
    ];

    final ecobook = [
      (
        index: 5,
        icon: AppImages.homeIcon,
        label: Strings.homeMenu,
        isSwitcher: false,
        backgroundColor: null,
        notificationCount: null
      ),
      (
        index: 6,
        icon: AppImages.chatIcon,
        label: Strings.ecoBookChatMenu,
        isSwitcher: false,
        backgroundColor: null,
        notificationCount: null
      ),
      (
        index: 7,
        icon: AppImages.ecomotoIcon,
        label: Strings.ecomotoMenu,
        isSwitcher: true,
        backgroundColor: AppColors.ecomotoSwitcherColor,
        notificationCount: null
      ),
      (
        index: 8,
        icon: AppImages.communityIcon,
        label: Strings.ecoBookCommunityMenu,
        isSwitcher: false,
        backgroundColor: null,
        notificationCount: null
      ),
      (
        index: 9,
        icon: AppImages.profileIcon,
        label: Strings.profileMenu,
        isSwitcher: false,
        backgroundColor: null,
        notificationCount: null
      )
    ];

    void onChange(({int index, String? switcher}) po) {
      widget.child.goBranch(
        po.index,
        initialLocation: po.index == widget.child.currentIndex,
      );
    }

    return Scaffold(
        drawerScrimColor: Colors.black54,
        key: context.read<AppScaffoldController>().key,
        endDrawer: const DashboardDrawer(),
        body: widget.child,
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: context
                    .watch<TripsCubit>()
                    .state
                    .hasActiveRental &&
                ![1, 3, 4, 5, 6, 7, 8, 9].contains(widget.child.currentIndex)
            ? [const SmartCarControls()]
            : null,
        bottomNavigationBar: CustomBottomNavigationBar(
          onTap: onChange,
          currentIndex: widget.child.currentIndex,
          items: showEcobook ? ecobook : ecomoto,
        ));
  }
}


// final x = BottomNavigationBar(
//   currentIndex: widget.child.currentIndex,  
//   onTap: (index) {
//     widget.child.goBranch(
//       index,
//       initialLocation: index == widget.child.currentIndex,
//     );
//   },
//   items: const [
//     BottomNavigationBarItem(
//       icon: BottomNavigationIcon(
//         color: AppColors.inActiveBottomNavigationColor,
//         name: AppImages.homeIcon,
//       ),
//       activeIcon: BottomNavigationIcon(
//         name: AppImages.homeIcon,
//       ),
//       label: Strings.homeMenu,
//     ),
//     BottomNavigationBarItem(
//       icon: BottomNavigationIcon(
//         color: AppColors.inActiveBottomNavigationColor,
//         name: AppImages.categoryIcon,
//       ),
//       activeIcon: BottomNavigationIcon(
//         name: AppImages.categoryIcon,
//       ),
//       label: Strings.tripsMenu,
//     ),
//     BottomNavigationBarItem(
//       icon: BottomNavigationIcon(
//         color: AppColors.inActiveBottomNavigationColor,
//         name: AppImages.ecoBookIcon,
//       ),
//       activeIcon: BottomNavigationIcon(
//         name: AppImages.ecoBookIcon,
//       ),
//       label: Strings.ecoBookMenu,
//     ),
//     BottomNavigationBarItem(
//       icon: BottomNavigationIcon(
//         color: AppColors.inActiveBottomNavigationColor,
//         name: AppImages.savedIcon,
//       ),
//       activeIcon: BottomNavigationIcon(
//         name: AppImages.savedIcon,
//       ),
//       label: Strings.savedMenu,
//     ),
//     BottomNavigationBarItem(
//       icon: BottomNavigationIcon(
//         color: AppColors.inActiveBottomNavigationColor,
//         name: AppImages.profileIcon,
//       ),
//       activeIcon: BottomNavigationIcon(
//         name: AppImages.profileIcon,
//       ),
//       label: Strings.profileMenu,
//     ),
//   ],
// );
