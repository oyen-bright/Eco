import 'package:emr_005/config/app_environment.dart';
import 'package:emr_005/utils/enums.dart';

class Endpoint {
  Endpoint._();

  static bool get isProduction {
    return AppEnvironment.environment == Environment.production;
  }

  static String vehicleData =
      "https://vpic.nhtsa.dot.gov/api/vehicles/decodevin/[vin]?format=json";

  static String pinataIpfs = "https://api.pinata.cloud/pinning/pinFileToIPFS";
  static String pinataIpfsUnpin =
      "https://api.pinata.cloud/pinning/unpin/[cid]";

  static String googleAutoComplete =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json";

  static String googlePlaceDetails =
      'https://maps.googleapis.com/maps/api/place/details/json';
  static String googlePlaceImage =
      'https://maps.googleapis.com/maps/api/place/textsearch/json';

  static String googleDistanceMetric =
      'https://maps.googleapis.com/maps/api/distancematrix/json';

  static String googleDirection =
      'https://maps.googleapis.com/maps/api/directions/json';

  static String pinataImageFetch = 'https://gateway.pinata.cloud/ipfs/';

  static String aiPriseVerificationResult = isProduction
      ? "https://api.aiprise.com/api/v1/verify/get_user_verification_result/"
      : "https://api-sandbox.aiprise.com/api/v1/verify/get_user_verification_result/";

  static String testDistanceMatrix =
      'https://trueway-matrix.p.rapidapi.com/CalculateDrivingMatrix';

  static String vehicleMarketValue =
      'https://marketvalue.vinaudit.com/getmarketvalue.php?key=[key]&vin=[vin]&period=182&mileage=null&country=USA&format=json';

  static String smartCarVin =
      "https://api.smartcar.com/v2.0/vehicles/[carId]/vin";
}
