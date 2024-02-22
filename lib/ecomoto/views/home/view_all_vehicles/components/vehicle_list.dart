part of view_all_vehicles;

class VehicleListView extends StatefulWidget {
  final ScrollController? scrollController;

  const VehicleListView({Key? key, this.scrollController}) : super(key: key);

  @override
  State<VehicleListView> createState() => VehicleListViewState();
}

class VehicleListViewState extends State<VehicleListView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VehicleCubit, VehicleState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (message, vehicles, _, __) {
            context.showSnackBar(message);
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.viewPaddingGrid,
                vertical: AppConstants.viewPaddingGrid),
            sliver: state.maybeWhen(
                loading: (vehicles, _, __) => _buildShimmerVehicleGrid(context),
                orElse: () => _buildVehicleGrid(
                    context,
                    state.maybeMap(
                      error: (errorState) => errorState.vehicles,
                      loaded: (
                        loadedState,
                      ) =>
                          loadedState.queryOptions != null
                              ? loadedState.filteredVehicles
                              : loadedState.vehicles,
                      orElse: () => [],
                    ))));
      },
    );
  }

  SliverGrid _buildVehicleGrid(BuildContext context, filteredVehicles) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: context.viewSize.height * .275,
        crossAxisCount: 2,
        childAspectRatio: .7,
        mainAxisSpacing: AppConstants.viewPaddingGrid,
        crossAxisSpacing: AppConstants.viewPaddingGrid,
      ),
      itemCount: filteredVehicles.length,
      itemBuilder: (BuildContext context, int index) {
        final vehicle = filteredVehicles[index];
        return VehicleCard(
          vehicle: vehicle,
          onPressed: (Vehicle vehicle) => AppRouter.router
              .push(EcomotoRoutes.vehicleRental, extra: vehicle),
        );
      },
    );
  }

  Widget _buildShimmerVehicleGrid(
    BuildContext context,
  ) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: context.viewSize.height * .275,
        crossAxisCount: 2,
        childAspectRatio: .7,
        mainAxisSpacing: AppConstants.viewPaddingGrid,
        crossAxisSpacing: AppConstants.viewPaddingGrid,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return VehicleCard.shimmer;
      },
    );
  }
}
