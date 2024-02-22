import 'package:emr_005/router/routes/general_routes/message_chat_route.dart';
import 'package:emr_005/router/routes/general_routes/vehicle_rental_routes.dart';

import 'auth_routes.dart';
import 'notification_routes.dart';
import 'onboarding_routes.dart';
import 'trip_routes.dart';
import 'vehicle_listing_routes.dart';

class GeneralRoutes {
  static final routes = [
    ...Onboarding.routes,
    ...Auth.routes,
    ...VehicleListing.routes,
    ...VehicleRental.routes,
    ...Notification.routes,
    ...MessageChatRoute.routes,
    ...Trips.routes
  ];
}
