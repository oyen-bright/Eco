import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/cubit/trips_cubit/trip_model.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/contract_and_agreement/contract_and_agreement_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/end_rental/end_rental.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/locate_vehicle/find_location/find_location.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/locate_vehicle/locate_vehicle_view/locate_vehicle_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/locate_vehicle/rental_started/rental_started_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/locate_vehicle/upload_image/upload_image_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/models/rental_input_data.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/payment_successful/payments_successful_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/rental_payment_method/rental_payment_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/select_rental_date/rental_date_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/vehicle_details/vehicle_details_images_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_rental/vehicle_details/vehicle_details_view.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/subpart_route_util.dart';

class VehicleRental {
  static final routes = [
    GoRoute(
        parentNavigatorKey: AppRouter.parentNavigatorKey,
        path: EcomotoRoutes.vehicleRental,
        pageBuilder: (context, state) {
          final vehicle = state.extra as Vehicle;
          return AppRouter.setupPage(
            child: VehicleDetailsView(vehicle: vehicle),
            state: state,
          );
        },
        routes: [
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleRentalDatePicker),
            pageBuilder: (context, state) {
              final vehicle = state.extra as Vehicle;
              return AppRouter.setupPage(
                child: RentalDateView(vehicle: vehicle),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleRentalPaymentsView),
            pageBuilder: (context, state) {
              final extra = state.extra as List;
              final vehicle = extra[0] as Vehicle;
              final rentalData = extra[1] as VehicleRentalModel;
              return AppRouter.setupPage(
                child: RentalPaymentView(
                  vehicle: vehicle,
                  rentalData: rentalData,
                ),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleRentalAgreementView),
            pageBuilder: (context, state) {
              final extra = state.extra as List;
              final vehicle = extra[0] as Vehicle;
              final rentalData = extra[1] as VehicleRentalModel;
              return AppRouter.setupPage(
                child: RentalAgreementView(
                  vehicle: vehicle,
                  rentalData: rentalData,
                ),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path:
                routeSubPath(EcomotoRoutes.vehicleRentalPaymentSuccessfulView),
            pageBuilder: (context, state) {
              final extra = state.extra as List;
              final vehicle = extra[0] as Vehicle;
              final rentalData = extra[1] as VehicleRentalModel;
              return AppRouter.setupPage(
                child: RentalPaymentSuccessful(
                  rentalModel: rentalData,
                  vehicle: vehicle,
                ),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleRentalFindLocationView),
            pageBuilder: (context, state) {
              final vehicle = state.extra as Vehicle;
              return AppRouter.setupPage(
                child: FindVehicleLocationView(
                  vehicle: vehicle,
                ),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleRentalLocateView),
            pageBuilder: (context, state) {
              final vehicle = (state.extra as Map<String, dynamic>)['vehicle'];
              final rentalID =
                  (state.extra as Map<String, dynamic>)['rentalID'];
              return AppRouter.setupPage(
                child: LocateVehicleView(
                  vehicle: vehicle,
                  rentalID: rentalID,
                ),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleImageViewer),
            pageBuilder: (context, state) {
              final vehicle = (state.extra as List)[0] as Vehicle;
              final selectedIndex = (state.extra as List)[1] as int;
              return AppRouter.setupPage(
                child: VehicleDetailsImagesView(
                  vehicleImages: vehicle.carImages,
                  selectedIndex: selectedIndex,
                ),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleRentalUploadImageView),
            pageBuilder: (context, state) {
              final rentalId = state.extra as String;
              return AppRouter.setupPage(
                child: UploadRentalImage(rentalID: rentalId),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleRentalStartedView),
            pageBuilder: (context, state) {
              return AppRouter.setupPage(
                child: const RentalStartedView(),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleRentalEndRentalView),
            pageBuilder: (context, state) {
              final vehicle = state.extra as Trip;
              return AppRouter.setupPage(
                child: EndRentalView(trip: vehicle),
                state: state,
              );
            },
          ),
        ]),
  ];
}
