part of '../host_view.dart';

class ActiveRentals extends StatelessWidget {
  const ActiveRentals({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> refreshData() async {
      await context.read<HostCubit>().getActiveRentals();
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
                  if (state.activeRental.isEmpty) {
                    return const EmptyState(
                      imageAsset: AppImages.noActiveVehicle,
                      prompt: Strings.activeVehicleEmptyStatePrompt,
                    );
                  }

                  final activeRentals = state.activeRental;
                  return _buildVehicleList(activeRentals);
                },
                orElse: () => _buildShimmerList(),
              );
            },
          ),
        ));
  }

  ListView _buildVehicleList(List<Trip> activeRentals) {
    return ListView.builder(
        // separatorBuilder: (context, index) => const SizedBox(
        //       height: 5,
        //     ),

        itemCount: activeRentals.length,
        padding: const EdgeInsets.only(bottom: 100, top: 10),
        itemBuilder: (context, index) {
          return RentalDetailsTile(
            //Notification for unread messages
            notificationCount: 10,
            onTap: () async {
              // context.read<MessagesCubit>().loadMessages(
              //     context.read<UserCubit>().state.userID,
              //     activeRentals[index].id);
              await AppRouter.router.push(
                EcomotoRoutes.ecomotoMessageChat,
                extra: [
                  context.read<UserCubit>().state.userID,
                  activeRentals[index].lessee,
                  activeRentals[index].id,
                ],
              );
            },
            trip: activeRentals[index],
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
