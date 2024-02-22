part of browse_vehicles;

class NearbyVehicles extends StatelessWidget {
  const NearbyVehicles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VehicleCubit, VehicleState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message, vehicles, _, __) {
            context.showSnackBar(message);
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: (vehicles, _, __) => vehicles.isEmpty
              ? _buildShimmerGrid(context, false)
              : _buildVehicleGrid(context, vehicles, false),
          orElse: () => _buildVehicleGrid(
            context,
            state.maybeMap(
              loaded: (loadedState) => loadedState.vehicles,
              orElse: () => [],
            ),
            state.isNearbyVehicles,
          ),
        );
      },
    );
  }

  Widget _buildShimmerGrid(BuildContext context, bool isNearbyVehicle) {
    return AppShimmer(
      child: Column(
        children: [
          GridListHeader(
            onPressed: null,
            textString: isNearbyVehicle
                ? Strings.nearbyVehicleText
                : Strings.availableVehicleTest,
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
          SizedBox(
            // height: context.viewSize.height * .275,

            height: context.viewSize.height * .26,
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.viewPaddingGrid),
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: context.viewSize.height * .21,
                  crossAxisCount: 1,
                  mainAxisSpacing: 10.0),
              itemCount: 5,
              itemBuilder: (context, index) {
                return VehicleCard.shimmer;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleGrid(
      BuildContext context, List<Vehicle> vehicles, bool isNearbyVehicle) {
    return Column(
      children: [
        GridListHeader(
          onPressed: () {
            AppRouter.router.push(EcomotoRoutes.homeAllVehicles);
          },
          textString: isNearbyVehicle
              ? Strings.nearbyVehicleText
              : Strings.availableVehicleTest,
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        SizedBox(
          // height: context.viewSize.height * .275,
          height: context.viewSize.height * .26,
          child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.viewPaddingGrid),
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: context.viewSize.height * .21,
                crossAxisCount: 1,
                mainAxisSpacing: 10.0),
            itemCount: vehicles.length > 6 ? 6 : vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return VehicleCard(
                vehicle: vehicle,
                onPressed: (Vehicle vehicle) => AppRouter.router
                    .push(EcomotoRoutes.vehicleRental, extra: vehicle),
              );
            },
          ),
        ),
      ],
    );
  }
}
