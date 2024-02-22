import 'package:emr_005/data/graphql/graphql_client.dart';
import 'package:emr_005/data/http/http_client.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/models/vehicle_input_data.dart';
import 'package:emr_005/services/ecomoto/vehicle_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late VehicleService vehicleService;

  setUp(() {
    vehicleService = VehicleService();
    HttpClient.init();
    GraphQLConfig.initClient();
  });

  // test('fetchVehicleData should return vehicleData on success', () async {
  //   const vehicleId = "6556b4e57546da0bf73cb795";
  //   final result = await vehicleService.fetchVehicleData(vehicleId);

  //   expect(result.error, isNotNull);
  //   expect(result.vehicleData, isNull);
  // });

  test('listVehicleNoStream should return transactionId on success', () async {
    //TODO: add a static userID
    // Arrange
    final vehicleDetails = VehicleModel()
      ..vin = 'ABC12392304820832093333'
      ..brand = 'Toyota'
      ..model = 'Camry'
      ..modelYear = '2022'
      ..numberOfSeats = 5
      ..color = 'Blue'
      ..capacity = 50
      ..vehicleType = 'Sedan'
      ..mileagePerCharge = 10
      ..insuranceProvider = 'XYZ Insurance'
      ..insurancePNumber = 123456
      ..policyNumber = 789012
      ..effectiveDate = DateTime.now()
      ..expiryDate = DateTime.now().add(const Duration(days: 30))
      ..isReserved = true
      ..isPublicParking = false
      ..pricePerHour = 10
      ..selectedDates = [DateTime.now()]
      ..isUpToDate = true
      ..isRegisteredOwner = true
      ..isVehicleMaintenance = false
      ..isAccident = false
      ..latitude = 37.7749
      ..longitude = -122.4194;

    // Act
    final result = await vehicleService.listVehicleNoStream(
        userID: "UserID",
        vehicleData: vehicleDetails,
        email: "Oyenbrihight@gmil.com");

    // Assert
    expect(result.error, isNull);
    expect(result.transactionId, isNotNull);
  });
}
