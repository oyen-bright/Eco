part of '../host_view.dart';

class BookedRentals extends StatelessWidget {
  const BookedRentals({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> refreshData() async {
      await context.read<HostCubit>().getBookedRentals();
      return;
    }

    return AppRefreshIndicator(
        onRefresh: refreshData,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.viewPaddingHorizontal),
          child: BlocConsumer<HostCubit, HostState>(
            listener: (context, state) {
              state.mapOrNull(
                error: (state) {
                  context.showSnackBar(state.errorMessage);
                },
              );
            },
            builder: (context, state) {
              return state.maybeMap(
                loaded: (state) {
                  if (state.bookedRental.isEmpty) {
                    return const EmptyState(
                      imageAsset: AppImages.noActiveVehicle,
                      prompt: Strings.activeVehicleEmptyStatePrompt,
                    );
                  }

                  final bookedRentals = state.bookedRental;
                  return _buildVehicleList(bookedRentals);
                },
                orElse: () => _buildShimmerList(),
              );
            },
          ),
        ));
  }

  ListView _buildVehicleList(List<Trip> bookedRentals) {
    //TODO: seperator for rental date
    return ListView.builder(
        // separatorBuilder: (context, index) => const SizedBox(
        //       height: 5,
        //     ),

        itemCount: bookedRentals.length,
        padding: const EdgeInsets.only(bottom: 100, top: 10),
        itemBuilder: (context, index) {
          return RentalDetailsTile(
            notificationCount: 10,
            onTap: () {
              //TODO: navigate to chat screen
            },
            trip: bookedRentals[index],
          );
        });
  }

  Widget _buildShimmerList() {
    return ListView.builder(
        // separatorBuilder: (_, __) => const SizedBox(
        //       height: 5,
        //     ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: 10,
        itemBuilder: (context, index) => RentalDetailsTile.shimmer);
  }
}
