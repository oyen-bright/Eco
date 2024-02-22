import 'package:emr_005/config/app_constants.dart';
import 'package:emr_005/ecomoto/cubit/trips_cubit/trips_cubit.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_cubit.dart';
import 'package:emr_005/themes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/back_to_homepage.dart';
import 'components/center_text.dart';
import 'components/header_image.dart';

class RentalStartedView extends StatelessWidget {
  const RentalStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TripsCubit>().getData();
    context.read<VehicleCubit>().getAllVehicle();
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            automaticallyImplyLeading: false,
          ),
          body: const Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppConstants.viewPaddingHorizontal),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  HeaderImage(),
                  SizedBox(
                    height: AppSizes.size20,
                  ),
                  CenterText(),
                  Spacer(
                    flex: 2,
                  ),
                  BackToHomePageButton(),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
