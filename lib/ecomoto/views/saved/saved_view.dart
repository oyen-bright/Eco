library saved_vehicles;

import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/services/ecomoto/vehicle_service.dart';
import 'package:emr_005/ui/components/cards/vehicle_card.dart';
import 'package:emr_005/ui/components/headers_footers/sliver_app_bar.dart';
import 'package:emr_005/ui/components/loading_indicators/refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'components/saved_vehicles.dart';
part 'components/vehicle_widget.dart';
part 'constants/strings.dart';

class SavedView extends StatefulWidget {
  const SavedView({super.key});

  @override
  SavedViewState createState() => SavedViewState();
}

class SavedViewState extends State<SavedView> {
  List<Vehicle> allVehicles = [];

  final ScrollController scrollController = ScrollController();

  Future<void> _refreshData() async {
    setState(() {});
  }

  Future<void> _loadVehicles() async {
    final response = await context.read<VehicleService>().getListedVehicles();

    if (mounted) {
      if (response.error == null) {
        setState(() {
          allVehicles = response.vehicle ?? [];
        });
      } else {
        context.showSnackBar('Fetching Failed');
        print(response.error);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: AppRefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            AppSliverViewBar.flexibleSpaceBar(
              collapsedHeight: 60,
              toolbarHeight: 60,
              pinned: false,
              floating: true,
              snap: true,
              title: Strings.appBarTitle,
            ),
            SavedVehicleList(
              vehicles: allVehicles,
              scrollController: scrollController,
            ),
          ],
        ),
      ),
    ));
  }
}
