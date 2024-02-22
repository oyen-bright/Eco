import 'package:bloc_test/bloc_test.dart';
import 'package:emr_005/cubits/loading_cubit/loading_cubit.dart';
import 'package:emr_005/cubits/user_cubit/user_cubit.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_cubit.dart';
import 'package:emr_005/ecomoto/cubit/wallet_cubit/wallet_cubit.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/models/vehicle_input_data.dart';
import 'package:emr_005/services/ecomoto/location_service.dart';
import 'package:emr_005/services/ecomoto/vehicle_service.dart';
import 'package:emr_005/services/pinata_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes for dependencies
class MockLoadingCubit extends Mock implements LoadingCubit {}

class MockUserCubit extends Mock implements UserCubit {}

class MockWalletCubit extends Mock implements WalletCubit {}

class MockVehicleService extends Mock implements VehicleService {}

class MockPinataService extends Mock implements PinataService {}

class MockLocationService extends Mock implements LocationService {}

void main() {
  late VehicleCubit vehicleCubit;
  late MockLoadingCubit loadingCubit;
  late MockUserCubit userCubit;
  late MockWalletCubit walletCubit;
  late MockVehicleService vehicleService;
  late MockPinataService pinataService;
  late MockLocationService locationService;

  setUp(() {
    loadingCubit = MockLoadingCubit();
    userCubit = MockUserCubit();
    walletCubit = MockWalletCubit();
    vehicleService = MockVehicleService();
    pinataService = MockPinataService();
    locationService = MockLocationService();

    registerFallbackValue(VehicleModel());

    vehicleCubit = VehicleCubit(loadingCubit, vehicleService, userCubit,
        locationService, walletCubit, pinataService);
  });

  group('VehicleCubit', () {
    // blocTest<VehicleCubit, VehicleState>(
    //   'emits [] when getVehicleDataViaVin is called successfully',
    //   build: () {
    //     when(() => vehicleService.fetchVehicleData(any())).thenAnswer(
    //       (_) async => (
    //         error: null,
    //         vehicleData: (
    //           make: "",
    //           modelYear: "",
    //           model: "",
    //           numberOfSeats: "",
    //           vehicleType: ""
    //         )
    //       ),
    //     );
    //     return vehicleCubit;
    //   },
    //   act: (cubit) => cubit.getVehicleDataViaVin('ABC123'),
    //   expect: () => [],
    // );

    // blocTest<VehicleCubit, VehicleState>(
    //   'emits [Loading, Loaded] when listVehicle is called successfully',
    //   build: () {
    //     // Mock the response from vehicleService.listVehicleNoStream
    //     when(() => vehicleService.listVehicleNoStream(
    //             vehicleData: any(named: 'vehicleData'),
    //             email: any(named: 'email')))
    //         .thenAnswer((_) async => ((error: "error", transactionId: null)));

    //     return VehicleCubit(loadingCubit, vehicleService, userCubit,
    //         walletCubit, pinataService);
    //   },
    //   act: (cubit) =>
    //       cubit.listVehicle(vehicleData: VehicleModel(), vehicleImages: []),
    //   expect: () => [],
    // );

    blocTest<VehicleCubit, VehicleState>(
      'emits [] when getAllVehicle is called successfully',
      build: () {
        when(() => vehicleService.getListedVehicles()).thenAnswer(
          (_) async => ((error: null, vehicle: null)),
        );
        return vehicleCubit;
      },
      act: (cubit) => cubit.getAllVehicle(),
      expect: () => [],
    );
  });
}
