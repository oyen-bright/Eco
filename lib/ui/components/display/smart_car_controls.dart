import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecomoto/cubit/trips_cubit/trip_model.dart';
import 'package:emr_005/ecomoto/cubit/trips_cubit/trips_cubit.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/smart_car_vehicle_model.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_cubit.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/extensions/context.dart';
import 'package:emr_005/extensions/widget.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:emr_005/themes/app_colors.dart';
import 'package:emr_005/themes/app_images.dart';
import 'package:emr_005/utils/km_miles_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SmartCarControls extends StatefulWidget {
  const SmartCarControls({Key? key}) : super(key: key);

  @override
  SmartCarControlsState createState() => SmartCarControlsState();
}

class SmartCarControlsState extends State<SmartCarControls>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  Vehicle? vehicle;
  Trip? trip;

  bool isExpanded = false;
  SmartCarVehicle? smartCarVehicle;

  @override
  void initState() {
    super.initState();
    trip = context.read<TripsCubit>().state.activeTripData;
    _getSmartCarDetails(trip?.carDetails).then((value) {
      if (mounted) {
        setState(() {
          smartCarVehicle = value;
        });
      }
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _heightAnimation = Tween<double>(begin: 100, end: 400).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _toggleExpanded() {
    isExpanded = !isExpanded;

    isExpanded
        ? _controller.forward().then((value) => setState(() {}))
        : _controller.reverse().then((value) => setState(() {}));
  }

  (String date, String time) _computeRentalEndDateTime(
      DateTime rentalEndDateTime) {
    String formattedDate =
        "${rentalEndDateTime.year}-${rentalEndDateTime.month}-${rentalEndDateTime.day}";
    String formattedTime =
        "${rentalEndDateTime.hour}:${rentalEndDateTime.minute}:${rentalEndDateTime.second}";

    return (formattedDate, formattedTime);
  }

  Future<SmartCarVehicle?> _getSmartCarDetails(Vehicle? vehicle) async {
    final response = await context
        .read<VehicleCubit>()
        .getSmartCarVehicle("0d607e4b-5ea2-48ae-87cf-2ef5787781e1");
    return response.vehicle;
  }

  String calDistanceCoved(double? odometer, String? startMilage) {
    if (odometer == null || startMilage == null) {
      return "";
    }
    return "${convertKilometersToMiles(odometer.toString()) - convertKilometersToMiles(startMilage)} mi";
  }

  void onChatLessor() {
    if (trip != null) {
      AppRouter.router.push(EcomotoRoutes.ecomotoMessageChat, extra: [
        context.read<UserCubit>().state.userID,
        trip?.lessor,
        trip?.id
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! > 4) {
          _toggleExpanded();
        } else if (details.primaryDelta! < -4) {
          _toggleExpanded();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colorScheme.primary,
        ),
        width: double.infinity,
        height: _heightAnimation.value,
        child: ClipRect(
          child: Stack(
            children: [
              Positioned.fill(
                child: OverflowBox(
                  maxHeight: 400,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 13),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 13),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!isExpanded)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: _buildLockUnlock(),
                            ),
                          )
                        else
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildLockUnlock(),
                                const Divider(
                                  thickness: 1.3,
                                  color: AppColors.lockUnlockGreen,
                                ),
                                InkWell(
                                  onTap: onChatLessor,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Chat Lessor",
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.white),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Image.asset(
                                        AppImages.chatIcon,
                                        color: Colors.white,
                                        scale: 2,
                                      )
                                    ],
                                  ).withHorViewPadding,
                                ),
                                const Divider(
                                  thickness: 1.3,
                                  color: AppColors.lockUnlockGreen,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: _buildInfoColumn(
                                        label: "Odometer",
                                        value: smartCarVehicle?.odometer != null
                                            ? "${convertKilometersToMiles(smartCarVehicle!.odometer.toString())}Mi"
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                      child: VerticalDivider(
                                        thickness: 1.3,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Expanded(
                                      child: _buildInfoColumn(
                                        label: "Charged",
                                        value: smartCarVehicle?.battery
                                                    .percentRemaining !=
                                                null
                                            ? "${smartCarVehicle!.battery.percentRemaining}%"
                                            : null,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ).withHorViewPadding,
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: _buildInfoColumn(
                                        label: "Return Time",
                                        value: _computeRentalEndDateTime(
                                                trip?.rentalEndDatetime ??
                                                    DateTime.now())
                                            .$2,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                      child: VerticalDivider(
                                        thickness: 1.3,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Expanded(
                                      child: _buildInfoColumn(
                                        label: "Return Date",
                                        value: _computeRentalEndDateTime(
                                                trip?.rentalEndDatetime ??
                                                    DateTime.now())
                                            .$1,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ).withHorViewPadding,
                                const Divider(
                                  thickness: 1.3,
                                  color: AppColors.lockUnlockGreen,
                                ),
                                _buildInfoColumn(
                                  label: "Distance Covered",
                                  value: smartCarVehicle != null
                                      ? calDistanceCoved(
                                          smartCarVehicle?.odometer,
                                          trip?.startMillage)
                                      : null,
                                  textAlign: TextAlign.center,
                                ).withHorViewPadding,
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: _toggleExpanded,
                  icon: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_down_outlined
                        : Icons.keyboard_arrow_up_outlined,
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn({
    required String label,
    required String? value,
    TextAlign textAlign = TextAlign.left,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          textAlign: textAlign,
          style: context.textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 5),
        if (value == null)
          const CircularProgressIndicator()
        else
          Text(
            value,
            style: context.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: textAlign,
          ),
      ],
    );
  }

  Widget _buildLockUnlock() {
    bool isUnlocking = false;
    bool isLocking = false;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLockUnlockItem(AppImages.lockedIcon, "Lock", () async {
          if (isUnlocking) {
            return;
          }
          isUnlocking = true;
          final response = await context
              .read<VehicleCubit>()
              .lockVehicle("0d607e4b-5ea2-48ae-87cf-2ef5787781e1");
          isUnlocking = false;
          if (context.mounted) {
            context.showSnackBar(response);
          }
        }),
        _buildLockUnlockItem(AppImages.unLockedIcon, "Unlock", () async {
          if (isLocking) {
            return;
          }
          isLocking = true;
          final response = await context
              .read<VehicleCubit>()
              .unlockVehicle("0d607e4b-5ea2-48ae-87cf-2ef5787781e1");
          isLocking = false;
          if (context.mounted) {
            context.showSnackBar(response);
          }
        }),
      ],
    ).withHorViewPadding;
  }

  Widget _buildLockUnlockItem(
      String image, String text, void Function()? onTap) {
    return Flexible(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Image.asset(
                image,
                scale: 2,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
