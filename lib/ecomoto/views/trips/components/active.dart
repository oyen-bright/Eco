part of "../trips_view.dart";

class Active extends StatelessWidget {
  const Active({super.key});

  @override
  Widget build(BuildContext context) {
    bool isUnlocking = false;
    bool isLocking = false;
    Future<void> refreshData() async {
      return context.read<TripsCubit>().getTrips();
    }

    void messageLessor(Trip trip) {
      AppRouter.router.push(EcomotoRoutes.ecomotoMessageChat, extra: [
        context.read<UserCubit>().state.userID,
        trip.lessor,
        trip.id
      ]);
    }

    void onEndTrip(Trip trip) {
      AppRouter.router
          .push(EcomotoRoutes.vehicleRentalEndRentalView, extra: trip);
    }

    void onUnlockVehicle() async {
      if (isUnlocking) {
        return;
      }

      isUnlocking = true;
      final response = await context
          .read<VehicleCubit>()
          .unlockVehicle("0d607e4b-5ea2-48ae-87cf-2ef5787781e1");
      isLocking = false;
      if (context.mounted) {
        context.showSnackBar(response);
      }
    }

    void onLockVehicle() async {
      if (isLocking) {
        return;
      }

      isLocking = true;
      final response = await context
          .read<VehicleCubit>()
          .lockVehicle("0d607e4b-5ea2-48ae-87cf-2ef5787781e1");
      isLocking = false;
      if (context.mounted) {
        context.showSnackBar(response);
      }
    }

    void onLocateVehicle(Trip trip) {
      AppRouter.router.push(EcomotoRoutes.vehicleRentalLocateView,
          extra: {'vehicle': trip.carDetails, 'rentalID': trip.id});
    }

    void onMenuSelected(String id, Trip trip) async {
      if (id == "message_lessor") {
        messageLessor(trip);
      }

      if (id == "end_trip") {
        onEndTrip(trip);
      }

      if (id == "message_ecomoto") {
        //TODO: message ecomoto
      }
    }

    return AppRefreshIndicator(
      onRefresh: refreshData,
      child: BlocConsumer<TripsCubit, TripsState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message, _, __, ___) {
              context.showSnackBar(message);
            },
          );
        },
        builder: (context, state) {
          return Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.viewPaddingHorizontal),
              child: state.maybeWhen(
                  orElse: () => TripDetails.shimmer,
                  loaded: (trips, _, __) {
                    if (trips.isEmpty) {
                      return const NoTrips(
                        title: Strings.noTrips,
                        subtitle: Strings.noTripsSubtitle,
                      );
                    }

                    final tripDetails = trips[0];

                    return TripDetails(
                      tripDetails: tripDetails,
                      onChat: () => messageLessor(tripDetails),
                      onEndTrip: () => onEndTrip(tripDetails),
                      onLocateVehicle: () => onLocateVehicle(tripDetails),
                      onLock: onLockVehicle,
                      onUnlock: onUnlockVehicle,
                      onMenuSelected: (id) => onMenuSelected(id, tripDetails),
                      menuOptions: const [
                        ('cancel_trip', 'Cancel Trip', Colors.red),
                        ('end_trip', 'End Trip', null),
                        // ('download_invoice', 'Download Invoice', null),
                        // ('share_vehicle', 'Share Vehicle', null),
                        // ('share_trips', 'Share Trips', null),
                        ('message_lessor', 'Message Lessor', null),
                        ('message_ecomoto', 'Message Ecomoto', null)
                      ],
                    );
                  }));
        },
      ),
    );
  }
}
