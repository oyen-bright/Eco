class FilterOptionsModel {
  late List<String> vehicleBrands = [];
  late List<String> vehicleTypes = [];
  late List<String> capacities = [];
  late List<String> brandCount = [];
  late List<String> capacityCount = [];
  late List<String> typeCount = [];

  @override
  String toString() {
    return 'FilterOptions( brands : $vehicleBrands, types : $vehicleTypes)';
  }
}
