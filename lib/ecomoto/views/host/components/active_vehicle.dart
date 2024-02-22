part of '../host_view.dart';

class ActiveVehicles extends StatelessWidget {
  const ActiveVehicles({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> refreshData() async {
      await context.read<HostCubit>().getVehicles();
      return;
    }

    return AppRefreshIndicator(
        onRefresh: refreshData,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.viewPaddingHorizontal),
          child: BlocConsumer<HostCubit, HostState>(listener: (context, state) {
            state.mapOrNull(
              error: (state) {
                context.showSnackBar(state.errorMessage);
              },
            );
          }, builder: (context, state) {
            return state.maybeMap(
              loaded: (state) {
                if (state.activeVehicles.isEmpty) {
                  return const EmptyState(
                    imageAsset: AppImages.noActiveVehicle,
                    prompt: Strings.activeVehicleEmptyStatePrompt,
                  );
                }

                final listedVehicles = state.activeVehicles;
                return _buildVehicleList(listedVehicles);
              },
              orElse: () => _buildShimmerList(),
            );
          }),
        ));
  }

  ListView _buildVehicleList(List<Vehicle> listedVehicles) {
    return ListView.builder(
        // separatorBuilder: (context, index) => const SizedBox(
        //       height: 5,
        //     ),

        itemCount: listedVehicles.length,
        padding: const EdgeInsets.only(bottom: 100, top: 10),
        itemBuilder: (context, index) {
          return VehicleDetailsTile(
            vehicle: listedVehicles[index],
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
        itemBuilder: (context, index) {
          return VehicleDetailsTile.shimmer;
        });
  }
}
