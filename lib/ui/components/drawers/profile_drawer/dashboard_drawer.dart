library profile_drawer;

import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/controllers/app_scaffold_controller.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'components/drawer_header.dart';
part 'components/drawer_list_tile.dart';
part 'constants/strings.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    print(context.viewSize.width / 1.7);
    return Drawer(
      shadowColor: Colors.black,
      width: (context.viewSize.width / 1.7) < 231
          ? 231
          : (context.viewSize.width / 1.7),
      backgroundColor: context.theme.scaffoldBackgroundColor,
      child: const SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileDrawerHeader(),
            Divider(),
            DrawerTileList(),
          ],
        ),
      ),
    );
  }
}
