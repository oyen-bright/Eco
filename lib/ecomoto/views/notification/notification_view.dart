import 'package:emr_005/ui/components/loading_indicators/refresh_indicator.dart';
import 'package:emr_005/ui/components/wrappers/profile_view_wrapper.dart';
import 'package:flutter/material.dart';

import 'components/notificaiton_list.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> refreshData() async {
      //TODO: refresh this view
    }

    return AppRefreshIndicator(
      displacement: 70,
      onRefresh: refreshData,
      child: ProfileViewWrapper(
          useSliver: true,
          automaticallyImplyLeading: true,
          title: "Notifications",
          body: const NotificationBuilder()),
    );

    // return Scaffold(
    //     body: SafeArea(
    //   child: AppRefreshIndicator(
    //     onRefresh: _refreshData,
    //     child: CustomScrollView(
    //       slivers: [
    //         AppSliverViewBar.flexibleSpaceBar(
    //           pinned: true,
    //           collapsedHeight: 70,
    //           toolbarHeight: 40,
    //           floating: false,
    //           // userFlexibleSpace: false,
    //           snap: false,
    //           titleSpacing: 0,
    //           title: 'Notifications',
    //         ),
    //         const SliverPadding(
    //           padding: EdgeInsets.symmetric(
    //               horizontal: AppConstants.viewPaddingHorizontal,
    //               vertical: AppConstants.viewPaddingVertical),
    //           sliver: NotificationBuilder(),
    //         ),
    //       ],
    //     ),
    //   ),
    // ));
  }
}
