part of "../trips_view.dart";

class Booked extends StatelessWidget {
  const Booked({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> refreshData() async {
      return context.read<TripsCubit>().getBooked();
    }

    return AppRefreshIndicator(
      onRefresh: refreshData,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.viewPaddingHorizontal),
        child: BlocConsumer<TripsCubit, TripsState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message, _, __, ___) {
                context.showSnackBar(message);
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => _buildShimmerList(),
              loaded: (_, __, trips) {
                if (trips.isEmpty) {
                  return const NoTrips(
                    title: Strings.noTrips,
                    subtitle: Strings.noTripsSubtitle,
                  );
                }

                return _buildTipList(trips);
              },
            );
          },
        ),
      ),
    );
  }

  ListView _buildTipList(List<Trip> trips) {
    //TODO: Seperator for booked date
    return ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(
              height: 10,
            ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: trips.length,
        itemBuilder: (context, index) {
          return TripDetailsTile(
            tripDetails: trips[index],
            onTap: () => AppRouter.router
                .push(EcomotoRoutes.tripsBookedDetails, extra: trips[index]),
          );
        });
  }

  Widget _buildShimmerList() {
    return ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(
              height: 10,
            ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: 10,
        itemBuilder: (context, index) {
          return TripDetailsTile.shimmer;
        });
  }
}
