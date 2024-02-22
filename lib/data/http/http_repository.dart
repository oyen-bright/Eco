import 'dart:io';

import 'package:emr_005/config/app_environment.dart';
import 'package:emr_005/data/http/http_client.dart';
import 'package:emr_005/utils/enums.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

import 'endpoints.dart';

class HttpRepository {
  HttpRepository._();

  static Future<Response> verifyAIpriseSessionID(String sessionId) async {
    return await HttpClient.getRequest(
        headers: {'X-API-KEY': AppEnvironment.aiPrice.apiKey},
        endpoint: Endpoint.aiPriseVerificationResult + sessionId);
  }
  //Legacy Code
  // static Future<Response> getVehicleData(String vin) async {
  //   return await HttpClient.getRequest(
  //       endpoint: Endpoint.vehicleData.replaceAll('[vin]', vin));
  // }

  static Future<Response> getVehicleMarketValue(String vin) async {
    return await HttpClient.getRequest(
        endpoint: Endpoint.vehicleMarketValue
            .replaceAll('[vin]', vin)
            .replaceAll('[key]', AppEnvironment.marketValueKey));
  }

  static Future<Response> pinFileToPinata(
    String filePath,
    void Function(double)? progress,
  ) async {
    return await HttpClient.multipartRequest(
      method: HttpMethod.post,
      headers: {
        'Authorization': 'Bearer ${AppEnvironment.pinataToken}',
      },
      endpoint: Endpoint.pinataIpfs,
      files: [
        (file: File(filePath), fileField: 'file', contentType: 'mediaFile')
      ],
    );
  }

  static Future<Response> unpinFilePinata(
    String cid,
  ) async {
    return await HttpClient.deleteRequest(
      headers: {
        'Authorization': 'Bearer ${AppEnvironment.pinataToken}',
      },
      endpoint: Endpoint.pinataIpfsUnpin.replaceAll('[cid]', cid),
    );
  }

  static Future<Response> getPlacesList(String placeId) async {
    final Map<String, String> queryParameters = {
      'input': placeId,
      'key': AppEnvironment.googleMapsApiKey,
    };

    return await HttpClient.getRequest(
        endpoint: Endpoint.googleAutoComplete,
        queryParameters: queryParameters);
  }

  static Future<Response> getPlaceDetails(String placeId) async {
    final Map<String, String> queryParameters = {
      'place_id': placeId,
      'key': AppEnvironment.googleMapsApiKey,
    };

    return await HttpClient.getRequest(
        endpoint: Endpoint.googlePlaceDetails,
        queryParameters: queryParameters);
  }

  static Future<Response> getPlacePicture(String reference) async {
    final Map<String, String> queryParameters = {
      'query': reference,
      'key': AppEnvironment.googleMapsApiKey,
    };

    return await HttpClient.getRequest(
        endpoint: Endpoint.googlePlaceImage, queryParameters: queryParameters);
  }

  static Future<Response> getDistanceBetweenGeoLocations({
    required (String long, String lat) from,
    required (String long, String lat) to,
  }) async {
    final Map<String, String> queryParameters = {
      'origins': '${from.$2},${from.$1}',
      'units': 'imperial',
      'destinations': '${to.$2},${to.$1}',
      'key': AppEnvironment.googleMapsApiKey,
    };

    // if (AppEnvironment.isDevelopment) {
    //   return await HttpClient.getRequest(
    //       endpoint: Endpoint.testDistanceMatrix,
    //       queryParameters: {
    //         'origins': '${from.$2},${from.$1}',
    //         'destinations': '${to.$2},${to.$1}',
    //       },
    //       headers: {
    //         'X-RapidAPI-Key':
    //             '6dd6019035msh9143ffe1df099a6p10ec8bjsn8511050c8778',
    //         'X-RapidAPI-Host': 'trueway-matrix.p.rapidapi.com'
    //       });
    // }

    return await HttpClient.getRequest(
        endpoint: Endpoint.googleDistanceMetric,
        queryParameters: queryParameters);
  }

  static Future<Response> getDirectionsBetweenLocations({
    required LatLng originLatLng,
    required LatLng destinationLatLng,
  }) async {
    final String origin = '${originLatLng.latitude},${originLatLng.longitude}';
    final String destination =
        '${destinationLatLng.latitude},${destinationLatLng.longitude}';

    final Map<String, String> queryParameters = {
      'origin': origin,
      'destination': destination,
      'key': AppEnvironment.googleMapsApiKey,
    };

    return await HttpClient.getRequest(
        endpoint: Endpoint.googleDirection, queryParameters: queryParameters);
  }

  //Legacy Code
  // static Future<Response> getVinByVehicleIdSmartCar(
  //     {required String vehicleId, required String accessToken}) async {
  //   return await HttpClient.getRequest(
  //     headers: {
  //       'Authorization': 'Bearer $accessToken',
  //     },
  //     endpoint: Endpoint.smartCarVin.replaceAll('[carId]', vehicleId),
  //   );
  // }
}
