part of saved_vehicles;

class SavedVehicleList extends StatefulWidget {
  final ScrollController? scrollController;
  final List<Vehicle> vehicles;
  const SavedVehicleList(
      {Key? key, this.scrollController, required this.vehicles})
      : super(key: key);

  @override
  State<SavedVehicleList> createState() => SavedVehicleListState();
}

class SavedVehicleListState extends State<SavedVehicleList> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.viewPaddingGrid,
          vertical: AppConstants.viewPaddingGrid),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: context.viewSize.height * .275,
          crossAxisCount: 2,
          childAspectRatio: .7,
          mainAxisSpacing: AppConstants.viewPaddingGrid,
          crossAxisSpacing: AppConstants.viewPaddingGrid,
        ),
        itemCount: widget.vehicles.length,
        itemBuilder: (BuildContext context, int index) {
          final vehicle = widget.vehicles[index];
          return VehicleCard.saved(
            vehicle: vehicle,
            onPressed: (Vehicle vehicle) => AppRouter.router
                .push(EcomotoRoutes.vehicleRental, extra: vehicle),
          );
        },
      ),
    );
  }
}
