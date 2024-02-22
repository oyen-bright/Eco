/*
  Initialize and configure GoRouter
 */
import 'package:flutter/foundation.dart' show immutable;

@immutable
class EcoBookRoutes {
  const EcoBookRoutes._();

  static const String root = '/ecoBook';
  static const String feeds = '$root/feeds';
  static const String community = '$root/community';
  static const String chat = '$root/chat';
  static const String profile = '$root/profile';

  static const String ecobookCommunityView = '$community/view-community';
  static const String createCommunityView = '$community/create-community';
  static const String addCommunityMembers =
      '$community/create-community/add-members';
}

@immutable
class EcomotoRoutes {
  const EcomotoRoutes._();

  static const String root = '/ecomoto';
  static const String home = '$root/home';
  static const String trips = '$root/trips';
  static const String host = '$root/host';
  static const String notifications = '$root/notifications';

  //Trips Routes

  static const String tripsBookedDetails = '$trips/booking-details';
  static const String tripsHistoryDetails = '$trips/history-details';

  //Home Routes
  static const String homeOnboarding = '/home-onboarding';
  static const String homeMapSearch = '/map-search';
  static const String homeAllVehicles = '/all-vehicles';

  //Ecobook Routes
  static const String ecoBook = '/ecoBook';
  static const String ecoBookExploreCommunities =
      '$ecoBook/explore-communities';
  static const String ecobookCommunityView = '$ecoBook/view-community';
  //static const String ecoBookMessageChats = '$ecoBook/message-chats';

  //Ecomoto messaging
  static const String ecomotoMessageChat = '$trips/message-chats';
  static const String ecomotoFullImageView = '$trips/full-image-view';
  // Profile Routes
  //Profile Routes
  static const String profile = '/profile-dashboard';
  static const String profilePayments = '$profile/payments';
  static const String profileProfile = '$profile/profile';
  static const String profileSettings = '$profile/settings';

  static const String profileSettingsGeneral =
      '$profileSettings/general-settings';
  static const String profileSettingPassword =
      '$profileSettings/change-password';
  static const String profileSettingsEmail = '$profileSettings/change-email';

  // Vehicle Listing Routes
  static const String vehicleListing = '/vehicle-listing';
  static const String vehicleListingSelectSmartCar =
      '$vehicleListing/select-smart-car';
  static const String vehicleListingSelectPlan =
      '$vehicleListing/select-vehicle-plan';
  static const String vehicleListingGeneralInformation =
      '$vehicleListing/general-information';
  static const String vehicleListingInsuranceInformation =
      '$vehicleListing/insurance-information';
  static const String vehicleListingExtraFeatures =
      '$vehicleListing/extra-features';
  static const String vehicleListingQualityStandards =
      '$vehicleListing/quality-standards';
  static const String vehicleListingSelectPrice = '$vehicleListing/pricing';
  static const String vehicleListingLocation =
      '$vehicleListing/vehicle-listing-location';
  static const String vehicleListingAvailability =
      '$vehicleListing/vehicle-availability';
  static const String vehicleListingSelectImages =
      '$vehicleListing/select-images';
  static const String vehicleListingListed = '$vehicleListing/vehicle-listed';

  // Vehicle Rental Routes
  static const String vehicleRental = '/vehicle-rental';
  static const String vehicleImageViewer =
      '$vehicleRental/vehicle-image-viewer';
  static const String vehicleRentalDatePicker =
      '$vehicleRental/rental-date-picker';
  static const String vehicleRentalPaymentsView =
      '$vehicleRental/rental-payment-view';
  static const String vehicleRentalAgreementView =
      '$vehicleRental/rental-agreement-view';
  static const String vehicleRentalPaymentSuccessfulView =
      '$vehicleRental/rental-payment-success-view';
  static const String vehicleRentalFindLocationView =
      '$vehicleRental/rental-find-location-view';
  static const String vehicleRentalLocateView =
      '$vehicleRental/rental-locate-vehicle-view';
  static const String vehicleRentalUnlockVehicleView =
      '$vehicleRental/rental-unlock-vehicle-view';
  static const String vehicleRentalUploadImageView =
      '$vehicleRental/rental-upload-image-view';
  static const String vehicleRentalStartedView =
      '$vehicleRental/rental-started-view';
  static const String vehicleRentalEndRentalView = '$vehicleRental/end-rental';
}

@immutable
class AppRoutes {
  const AppRoutes._();

  static const String root = '/';
  static const String splash = '/splash';
  static const String onBoarding = '/onboarding';

  // Authentication Routes
  static const String login = '/login';
  static const String signUp = '/signup';
  static const String forgetPassword = '/forget-password';
  static const String forgetPasswordOtpView = '/forget-password-otp-view';
  static const String forgetPasswordChangeView = '/forget-password-change-view';

  static const String activateAccount = '/activate-account';
  static const String otpVerification = '/otp-verification';
  static const String completeProfile = '/complete-profile';

  static const EcoBookRoutes ecobook = EcoBookRoutes._();
  static const EcomotoRoutes ecomoto = EcomotoRoutes._();
}
