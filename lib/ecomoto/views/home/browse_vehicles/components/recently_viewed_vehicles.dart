part of browse_vehicles;

class RecentlyViewedVehicles extends StatelessWidget {
  const RecentlyViewedVehicles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<VehicleCubit, VehicleState>(
      listener: (context, state) {
        context.read<ViewedVehicleCubit>().reload(state);
      },
      child: BlocBuilder<ViewedVehicleCubit, ViewedVehicleState>(
        builder: (context, state) {
          return state.maybeWhen(
            initial: () => _buildShimmerGrid(context),
            loaded: (loadedState) => _buildVehicleGrid(
                context,
                loadedState
                    .map((e) =>
                        (context.read<VehicleCubit>().getVehicleById(e))!)
                    .toList()),
            orElse: () => _buildVehicleGrid(context, []),
          );
        },
      ),
    );
  }

  Widget _buildShimmerGrid(BuildContext context) {
    return AppShimmer(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const GridListHeader(
            onPressed: null,
            textString: Strings.recentlyViewedText,
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
          SizedBox(
            // height: context.viewSize.height * .26,
            height: context.viewSize.height * .275,

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
              itemBuilder: (context, index) => VehicleCard.shimmer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleGrid(BuildContext context, List<Vehicle> vehicles) {
    if (vehicles.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        const SizedBox(height: 20),
        const GridListHeader(
          onPressed: null,
          textString: Strings.recentlyViewedText,
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        SizedBox(
          // height: context.viewSize.height * .26,
          height: context.viewSize.height * .275,

          child: GridView.builder(
            // shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.viewPaddingGrid),
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: context.viewSize.height * .21,
                crossAxisCount: 1,
                mainAxisSpacing: 10.0),
            itemCount: vehicles.length,
            itemBuilder: (context, index) => VehicleCard(
              vehicle: vehicles[index],
              onPressed: (Vehicle vehicle) => AppRouter.router
                  .push(EcomotoRoutes.vehicleRental, extra: vehicle),
            ),
          ),
        ),
      ],
    );
  }
}
