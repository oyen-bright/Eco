import 'package:emr_005/config/app_routes.dart';
import 'package:emr_005/ecomoto/cubit/vehicle_cubit/smart_car_vehicle_model.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/extra_features/extra_features_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/general_information/general_information_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/insurance_information/insurance_information_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/listing_successful/listing_successful_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/models/vehicle_input_data.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/onboarding/vehicle_onboarding_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/quality_standards/quality_standards_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/select_plan/select_plan_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/select_price/select_price_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/select_smart_car/select_smart_car_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/showcase_vehicle/showcase_vehicle_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/vehicle_availability/vehicle_availability_view.dart';
import 'package:emr_005/ecomoto/views/vehicle_listing/vehicle_listing_location/listing_location_view.dart';
import 'package:emr_005/router/app_router.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/subpart_route_util.dart';

class VehicleListing {
  static final routes = [
    GoRoute(
        parentNavigatorKey: AppRouter.parentNavigatorKey,
        path: EcomotoRoutes.vehicleListing,
        pageBuilder: (context, state) {
          return AppRouter.setupPage(
            child: const VehicleOnboardingView(),
            state: state,
          );
        },
        routes: [
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleListingGeneralInformation),
            pageBuilder: (context, state) {
              final vehicleInputData = state.extra as VehicleModel;

              return AppRouter.setupPage(
                child: GeneralInformationFormView(
                  vehicleInputData: vehicleInputData,
                ),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleListingSelectSmartCar),
            pageBuilder: (context, state) {
              final smartCarVehicles = state.extra as List<SmartCarVehicle>;

              return AppRouter.setupPage(
                child: SelectSmartCarView(
                  vehicles: smartCarVehicles,
                ),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path:
                routeSubPath(EcomotoRoutes.vehicleListingInsuranceInformation),
            pageBuilder: (context, state) {
              final vehicleInputData = state.extra as VehicleModel;
              return AppRouter.setupPage(
                child: InsuranceInformationView(
                    vehicleInputData: vehicleInputData),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleListingExtraFeatures),
            pageBuilder: (context, state) {
              final vehicleInputData = state.extra as VehicleModel;
              return AppRouter.setupPage(
                child: ExtraFeaturesView(vehicleInputData: vehicleInputData),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleListingQualityStandards),
            pageBuilder: (context, state) {
              final vehicleInputData = state.extra as VehicleModel;
              return AppRouter.setupPage(
                child: QualityStandardsView(vehicleInputData: vehicleInputData),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleListingSelectPrice),
            pageBuilder: (context, state) {
              final vehicleInputData = state.extra as VehicleModel;
              return AppRouter.setupPage(
                child: SelectPriceView(vehicleInputData: vehicleInputData),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleListingLocation),
            pageBuilder: (context, state) {
              final vehicleInputData = state.extra as VehicleModel;
              return AppRouter.setupPage(
                child: ListingLocationView(vehicleInputData: vehicleInputData),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleListingAvailability),
            pageBuilder: (context, state) {
              final vehicleInputData = state.extra as VehicleModel;
              return AppRouter.setupPage(
                child:
                    VehicleAvailabilityView(vehicleInputData: vehicleInputData),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleListingSelectPlan),
            pageBuilder: (context, state) {
              final vehicleInputData = state.extra as VehicleModel;
              return AppRouter.setupPage(
                child: SelectVehiclePlanView(
                  vehicleInputData: vehicleInputData,
                ),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleListingSelectImages),
            pageBuilder: (context, state) {
              final vehicleInputData = state.extra as VehicleModel;
              return AppRouter.setupPage(
                child: ShowCaseVehicleView(vehicleInputData: vehicleInputData),
                state: state,
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: AppRouter.parentNavigatorKey,
            path: routeSubPath(EcomotoRoutes.vehicleListingListed),
            pageBuilder: (context, state) {
              return AppRouter.setupPage(
                child: const ListingSuccessfulView(),
                state: state,
              );
            },
          )
        ]),
  ];
}
