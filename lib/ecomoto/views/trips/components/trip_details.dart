part of '../trips_view.dart';

class TripDetails extends StatelessWidget {
  final Trip tripDetails;
  final dynamic Function(String)? onMenuSelected;
  final bool showLockUnlock;
  final bool showEndTrip;
  final bool showDividers;
  final bool isBooked;
  final Function()? onChat;
  final void Function()? onLock;
  final void Function()? onUnlock;
  final void Function()? onEndTrip;
  final void Function()? onLocateVehicle;

  final List<(String, String, MaterialColor?)>? menuOptions;

  static Widget get shimmer {
    return AppShimmer(child: TripDetails(tripDetails: Trip.dummy()));
  }

  const TripDetails(
      {super.key,
      required this.tripDetails,
      this.onMenuSelected,
      this.onLock,
      this.onUnlock,
      this.showDividers = true,
      this.showLockUnlock = true,
      this.showEndTrip = true,
      this.onEndTrip,
      this.onLocateVehicle,
      this.isBooked = false,
      this.onChat,
      this.menuOptions});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                _buildTripOverview(tripDetails, context),
                const SizedBox(
                  height: 30,
                ),
                _buildBookingDetails(tripDetails, context)
              ],
            ),
          ),
        ),
        _buildTripActions(
            tripDetails, context, showEndTrip, showLockUnlock, showDividers),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildTripActions(Trip tripDetails, BuildContext context,
      bool showEndTrip, bool showLockUnlock, bool showDividers) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showLockUnlock &&
              (tripDetails.rentalStatus != RentalStatus.ready)) ...{
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        AppImages.lockedIcon,
                        scale: 2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: AppElevatedButton(
                              elevation: 0,
                              onPressed: onLock != null
                                  ? () {
                                      haptic(HapticFeedbackType.light);
                                      onLock?.call();
                                    }
                                  : null,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              borderColor: AppColors.primaryColor,
                              titleColor: context.colorScheme.onBackground,
                              backgroundColor:
                                  context.theme.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(5),
                              title: Strings.lockButtonTitle))
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        AppImages.unLockedIcon,
                        scale: 2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: AppElevatedButton(
                              elevation: 0,
                              onPressed: onUnlock != null
                                  ? () {
                                      haptic(HapticFeedbackType.light);
                                      onUnlock?.call();
                                    }
                                  : null,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              borderColor: AppColors.primaryColor,
                              titleColor: context.colorScheme.onBackground,
                              backgroundColor:
                                  context.theme.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(5),
                              title: Strings.unlockButtonTitle))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          },
          if (showDividers) const Divider(),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (tripDetails.rentalStatus == RentalStatus.ready)
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 110),
                  child: AppElevatedButton(
                    borderRadius: BorderRadius.circular(3),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    title: Strings.locateVehicleButtonTitle,
                    onPressed: onLocateVehicle,
                  ),
                )
              else if (!isBooked)
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 110),
                  child: AppElevatedButton.withIcon(
                    visualDensity: null,
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        AppImages.chatIcon,
                        color: AppColors.approvalGreen,
                        scale: 2.3,
                      ),
                    ),
                    isIconReversed: true,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    borderColor: AppColors.primaryColor,
                    foregroundColor: AppColors.approvalGreen,
                    backgroundColor: context.theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(3),
                    title: Strings.chatButtonTitle,
                    onPressed: onChat,
                  ),
                ),
              if (showEndTrip) ...{
                const SizedBox(
                  width: 20,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 110),
                  child: AppElevatedButton(
                    borderRadius: BorderRadius.circular(3),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    title: Strings.endTripButtonTitle,
                    onPressed: onEndTrip,
                  ),
                )
              }
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (showDividers) const Divider(),
        ].reversed.toList(),
      ),
    );
  }

  Widget _buildTripOverview(Trip tripDetails, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 90,
          height: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            child: (tripDetails.carDetails.carImages.isNotEmpty)
                ? AppCachedImage(
                    imageUrl: (tripDetails.carDetails.carImages..shuffle())
                        .first['imageUrl'],
                    withPinata: true,
                  )
                : Image.asset(
                    AppImages.noVehicleImage,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () => copyToClipboard(context, tripDetails.id),
                  child: Text(
                    "${Strings.bookingIDTitle}: #${tripDetails.id}",
                    maxLines: 1,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: '${Strings.plateNumberTitle}: ',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.darkGreyColor,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.30,
                    ),
                  ),
                  TextSpan(
                    text: tripDetails.carDetails.plateNumber ?? "N/A",
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.darkGreyColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.30,
                    ),
                  ),
                ])),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: '${Strings.colorTitle}: ',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.darkGreyColor,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.30,
                    ),
                  ),
                  TextSpan(
                    text: tripDetails.carDetails.color,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.darkGreyColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.30,
                    ),
                  ),
                ])),
              ],
            )),
        const SizedBox(
          width: 10,
        ),
        if ((tripDetails.rentalStatus != RentalStatus.ready))
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (menuOptions != null)
                AppPopUpMenu(
                    options: menuOptions!,
                    isVertical: true,
                    onSelected: onMenuSelected),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: tripDetails.rentalStatus != null &&
                            tripDetails.rentalStatus != RentalStatus.completed
                        ? AppColors.rentActiveColorLight
                        : AppColors.rentCompletedColorLight,
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadiusSmall)),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.size10, vertical: AppSizes.size6),
                child: Text(
                  (tripDetails.rentalStatus?.value ?? "N/A").toString(),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: tripDetails.rentalStatus != null &&
                            tripDetails.rentalStatus != RentalStatus.completed
                        ? AppColors.rentActiveColor
                        : AppColors.rentCompletedColor,
                  ),
                ),
              )
            ],
          )
      ],
    );
  }

  Widget _buildBookingDetails(Trip tripDetails, BuildContext context) {
    return _BookingDetails(
      tripDetails: tripDetails,
      isBooked: isBooked,
    );
  }
}

class _BookingDetails extends StatefulWidget {
  final Trip tripDetails;
  final bool isBooked;
  const _BookingDetails({required this.tripDetails, this.isBooked = false});

  @override
  State<_BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<_BookingDetails>
    with AutomaticKeepAliveClientMixin, LocationMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    getSmartCarDetails();
    getReturnLocation();
  }

  void getSmartCarDetails() async {
=charge    final response = await context
        .read<VehicleCubit>()
        .getSmartCarVehicle("0d607e4b-5ea2-48ae-87cf-2ef5787781e1");
    if (response.error == null) {
      final percentRemaining = response.vehicle?.battery.percentRemaining;
      if (percentRemaining != null) {
        setState(() {
          charge = "$percentRemaining%";
        });
      }
      final odometer = response.vehicle?.odometer;
      final startMillage = widget.tripDetails.startMillage;

      if (odometer != null) {
        setState(() {
          distanceCovered =
              "${convertKilometersToMiles(odometer.toString()) - convertKilometersToMiles(startMillage)} miles";
        });
      }
    }
  }

  void getReturnLocation() async {
    final parkedLocation = widget.tripDetails.carDetails.parkedLocation;
    if (parkedLocation != null) {
      final latitude = parkedLocation['latitude'];
      final longitude = parkedLocation['longitude'];

      final response = await context
          .read<LocationService>()
          .getPlaceMarkFromCoordinates(latitude, longitude);

      if (response.error == null) {
        List<Placemark> placemarks = response.data!;
        if (placemarks.isNotEmpty) {
          setState(() {
            returnLocation = formatPlaceWithTown(placemarks).mainTown;
          });
        }
      }
    }
  }

  String? charge;
  String? distanceCovered;
  String? returnLocation;

  SizedBox buildData(BuildContext context,
      {required String title,
      required List<({String? subtitle, String title})> row1,
      List<({String? subtitle, String title})>? row2,
      List<({String? subtitle, String title})>? row3}) {
    Expanded featureItem(({String? subtitle, String title}) e) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                e.title,
                maxLines: 1,
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 13,
                    color: AppColors.primaryLight),
              ),
              const SizedBox(
                height: 5,
              ),
              if (e.subtitle == null)
                const AppShimmer(
                  child: AutoSizeText(
                    Strings.loadingPrompt,
                    maxLines: 1,
                    minFontSize: 14,
                    style: TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark),
                  ),
                )
              else
                GestureDetector(
                  onTap: () => copyToClipboard(context, e.subtitle.toString()),
                  child: AutoSizeText(
                    '${e.subtitle}',
                    maxLines: 1,
                    minFontSize: 14,
                    style: const TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark),
                  ),
                )
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AutoSizeText(
            title,
            style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold, color: AppColors.primaryLight),
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: row1.map((e) => featureItem(e)).toList(),
          ),
          const SizedBox(
            height: AppSizes.size12,
          ),
          if (row2 != null) ...{
            Row(
              mainAxisSize: MainAxisSize.max,
              children: row2.map((e) => featureItem(e)).toList(),
            ),
            const SizedBox(
              height: AppSizes.size12,
            ),
          },
          if (row3 != null) ...{
            Row(
              mainAxisSize: MainAxisSize.max,
              children: row3.map((e) => featureItem(e)).toList(),
            ),
            const SizedBox(
              height: AppSizes.size12,
            ),
          }
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        if (widget.isBooked) ...{
          buildData(
            context,
            title: Strings.featuresTitle,
            row1: [
              (
                title: Strings.modelTitle,
                subtitle: widget.tripDetails.carDetails.model
              ),
              (
                title: Strings.colorTitle,
                subtitle: widget.tripDetails.carDetails.color
              ),
              (
                title: Strings.capacityTitle,
                subtitle:
                    "${widget.tripDetails.carDetails.capacity} ${Strings.peopleTitle}"
              ),
            ],
            row2: [
              (
                title: Strings.plateNumberTitle,
                subtitle: widget.tripDetails.carDetails.plateNumber ?? "N/A"
              ),
              (
                title: Strings.millagePerChargeTitle,
                subtitle:
                    widget.tripDetails.carDetails.millagePerCharge.toString()
              ),
              (title: "", subtitle: ""),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          buildData(context, title: Strings.bookingDetailsTitle, row1: [
            (
              title: Strings.bookingIDTitle,
              subtitle: widget.tripDetails.id.toString()
            ),
            (
              title: Strings.durationTitle,
              subtitle:
                  "${getDifferenceInDays(widget.tripDetails.rentalStartDatetime, widget.tripDetails.rentalEndDatetime)} days"
            ),
          ], row2: [
            (
              title: Strings.startTimeTitle,
              subtitle: DateFormat('h a')
                  .format(widget.tripDetails.rentalStartDatetime)
            ),
            (
              title: Strings.startDateTitle,
              subtitle: DateFormat('MM-dd-yyyy')
                  .format(widget.tripDetails.rentalStartDatetime)
            ),
            (
              title: Strings.returnTimeTitle,
              subtitle:
                  DateFormat('h a').format(widget.tripDetails.rentalEndDatetime)
            ),
            (
              title: Strings.returnDateTitle,
              subtitle: DateFormat('MM-dd-yyyy')
                  .format(widget.tripDetails.rentalEndDatetime)
            ),
          ], row3: [
            (title: Strings.returnLocationTitle, subtitle: returnLocation),
            (title: Strings.pickUpLocationTitle, subtitle: returnLocation),
          ]),
        } else
          buildData(context, title: Strings.bookingDetailsTitle, row1: [
            (
              title: Strings.bookingIDTitle,
              subtitle: widget.tripDetails.id.toString()
            ),
            (
              title: Strings.durationTitle,
              subtitle:
                  "${getDifferenceInDays(widget.tripDetails.rentalStartDatetime, widget.tripDetails.rentalEndDatetime)} days"
            ),
            (
              title: Strings.returnTimeTitle,
              subtitle: DateFormat(Constants.timeFormate)
                  .format(widget.tripDetails.rentalEndDatetime)
            ),
            (
              title: Strings.returnDateTitle,
              subtitle: DateFormat(Constants.dateFormate)
                  .format(widget.tripDetails.rentalEndDatetime)
            ),
          ], row2: [
            (title: Strings.returnLocationTitle, subtitle: returnLocation),
            (title: Strings.distanceCoveredTitle, subtitle: distanceCovered),
          ], row3: [
            (title: Strings.chargedTitle, subtitle: charge),
          ]),
      ],
    );
  }
}
