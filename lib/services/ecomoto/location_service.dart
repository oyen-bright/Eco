import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:emr_005/config/app_config.dart';
import 'package:emr_005/config/app_environment.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:permission_handler/permission_handler.dart';

import '../../data/http/http_repository.dart';
import '../../ecomoto/config/cache_manager/cache_manager_config.dart';

class LocationService {
  const LocationService();

  Future<({String? error, List predictions})> fetchPlaceList(
      {required String placeId}) async {
    try {
      final response = await HttpRepository.getPlacesList(placeId);

      if (response.statusCode == 200) {
        final List<dynamic>? predictions =
            json.decode(response.body)['predictions'];

        return (error: null, predictions: predictions ?? []);
      } else {
        return (
          error:
              'Failed to fetch place details. Status code: ${response.statusCode}',
          predictions: []
        );
      }
    } catch (e) {
      return (error: 'Error fetching place details: $e', predictions: []);
    }
  }

  Future<({String? error, Map? data})> placeDetails(String placeId) async {
    try {
      final response = await HttpRepository.getPlaceDetails(placeId);

      if (response.statusCode == 200) {
        return (error: null, data: json.decode(response.body) as Map);
      } else {
        return (error: 'Failed to load place details', data: null);
      }
    } catch (e) {
      return (error: 'Error fetching place details: $e', data: null);
    }
  }

  // Future<({String? error, ({String distance, String duration})? data})>
  //     distanceBetweenGeoLocations(
  //         {({String long, String lat})? currentLocation,
  //         required ({String long, String lat}) destination}) async {
  //   try {
  //     const ({String lat, String long})? userLocation =
  //         (long: '76.77430094520798', lat: '19.266631037367063');

  //     final response = await HttpRepository.getDistanceBetweenGeoLocations(
  //         from: (userLocation.long, userLocation.lat),
  //         to: (destination.long, destination.lat));

  //     if (response.statusCode == 200) {
  //       var jsonResponse = jsonDecode(response.body);
  //       if (jsonResponse['rows'][0]['elements'][0]['status'] == 'OK') {
  //         var distance = jsonResponse['rows'][0]['elements'][0]['distance']
  //             ['text'] as String;
  //         var duration = jsonResponse['rows'][0]['elements'][0]['duration']
  //             ['text'] as String;

  //         return (error: null, data: (distance: distance, duration: duration));
  //       }
  //     }
  //     return (error: 'Unavailable', data: null);
  //   } catch (e) {
  //     return (error: 'Unavailable', data: null);
  //   }
  // }

  String _convertDistance(double meters) {
    const double metersInMile = 1609.34;
    const double metersInFoot = 0.3048;

    double miles = meters / metersInMile;
    double feet = meters / metersInFoot;

    if (miles < 0.1) {
      return '${feet.round()} ft';
    } else {
      return '${miles.toStringAsFixed(2)} mi';
    }
  }

  double calculateDistanceBetweenGeoLocationsWithHaversine({
    required ({String long, String lat}) origin,
    required ({String long, String lat}) destination,
  }) {
    return Geolocator.distanceBetween(
        double.parse(origin.lat),
        double.parse(origin.long),
        double.parse(destination.lat),
        double.parse(destination.long));
  }

  Future<
          ({
            String? error,
            bool hasPermission,
            ({String distance, String duration})? data
          })>
      distanceBetweenGeoLocations(
          {({String long, String lat})? currentLocation,
          required ({String long, String lat}) destination,
          bool useCache = true,
          ({
            bool use,
            bool convertToFeet
          }) haversine = (use: false, convertToFeet: true),
          bool userSavedLocation = false,
          LocationAccuracy desiredAccuracy = LocationAccuracy.high}) async {
    try {
      //   print("called");
      final lastSavedUserLocation = AppConfig.getUserLocation;
      final userLocation =
          currentLocation ?? (userSavedLocation ? lastSavedUserLocation : null);

      if (userLocation == null) {
        final response = await checkLocationPermission(shouldRequest: false);
        if (response.isGranted) {
          final newCurrentLocation =
              (await getCurrentLocation(desiredAccuracy)).position;

          if (newCurrentLocation != null) {
            return distanceBetweenGeoLocations(
                useCache: useCache,
                haversine: haversine,
                desiredAccuracy: desiredAccuracy,
                destination: destination,
                currentLocation: (
                  long: '${newCurrentLocation.longitude}',
                  lat: '${newCurrentLocation.latitude}'
                ));
          }
        }
        return (error: 'Unavailable', data: null, hasPermission: false);
      }

      String cacheKey =
          '${userLocation.long},${userLocation.lat}-${destination.long},${destination.lat}';

      if (useCache) {
        var cachedData = CacheManager.readLocationCache(cacheKey);
        if (cachedData != null) {
          return cachedData.isAvailable
              ? (error: null, data: cachedData.data, hasPermission: true)
              : (error: 'Unavailable', data: null, hasPermission: true);
        }
      }

      if (haversine.use) {
        final response = calculateDistanceBetweenGeoLocationsWithHaversine(
            origin: (lat: userLocation.lat, long: userLocation.long),
            destination: (lat: destination.lat, long: destination.long));

        final distanceInMiles = haversine.convertToFeet
            ? _convertDistance(response)
            : response.toString();

        return (
          error: null,
          data: (distance: distanceInMiles, duration: ""),
          hasPermission: true
        );
      }

      final response = await HttpRepository.getDistanceBetweenGeoLocations(
          from: (userLocation.long, userLocation.lat),
          to: (destination.long, destination.lat));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['rows'][0]['elements'][0]['status'] == 'OK') {
          var distance = jsonResponse['rows'][0]['elements'][0]['distance']
              ['text'] as String;
          var duration = jsonResponse['rows'][0]['elements'][0]['duration']
              ['text'] as String;

          await CacheManager.writeLocationCache(
              cacheKey, (distance: distance, duration: duration));

          return (
            error: null,
            data: (distance: distance, duration: duration),
            hasPermission: true
          );
        } else if (jsonResponse['rows'][0]['elements'][0]['status'] ==
            'ZERO_RESULTS') {
          await CacheManager.writeLocationCache(cacheKey, null,
              isAvailable: false);
        }
      }
      return (error: 'Unavailable', data: null, hasPermission: true);
    } catch (e) {
      return (error: 'Unavailable', data: null, hasPermission: true);
    }
  }

  Future<
      ({
        String? error,
        ({String distance, String duration, List steps})? data
      })> getDirectionBetweenGeoLocations({
    required LatLng originLatLng,
    required LatLng destinationLatLng,
    bool useCache = true,
  }) async {
    try {
      String cacheKey =
          '${originLatLng.toString()}-${destinationLatLng.toString()}';

      if (useCache) {
        var cachedData = CacheManager.readDirectionLocationCache(cacheKey);
        if (cachedData != null) {
          return cachedData.isAvailable
              ? (error: null, data: cachedData.data)
              : (error: 'Unavailable', data: null);
        }
      }

      final response = await HttpRepository.getDirectionsBetweenLocations(
        originLatLng: originLatLng,
        destinationLatLng: destinationLatLng,
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == 'OK') {
          var distance = jsonResponse['routes'][0]['legs'][0]['distance']
              ['text'] as String;
          var duration = jsonResponse['routes'][0]['legs'][0]['duration']
              ['text'] as String;
          var steps = jsonResponse['routes'][0]['legs'][0]['steps'] as List;

          await CacheManager.writeDirectionLocationCache(
              cacheKey, (distance: distance, duration: duration, steps: steps));
          return (
            error: null,
            data: (distance: distance, duration: duration, steps: steps)
          );
        } else if (jsonResponse['rows'][0]['elements'][0]['status'] ==
            'ZERO_RESULTS') {
          await CacheManager.writeDirectionLocationCache(cacheKey, null,
              isAvailable: false);
        }
      }
      return (error: 'Unavailable', data: null);
    } catch (e) {
      return (error: 'Unavailable', data: null);
    }
  }

  Future<({String? error, bool isGranted, LocationPermission? status})>
      checkLocationPermission({bool shouldRequest = true}) async {
    // var status = await Permission.location.request();
    // if (kDebugMode && Platform.isIOS && AppEnvironment.isDevelopment) {
    //   return (error: null, isGranted: true, status: status);
    // }
    // if (status.isGranted) {
    //   return (error: null, isGranted: true, status: status);
    // } else if (status.isPermanentlyDenied) {
    //   return (
    //     error:
    //         "Location service is permanently denied. Please enable it in settings.",
    //     isGranted: false,
    //     status: status
    //   );
    // } else if (status.isDenied) {
    //   return (
    //     error: "Location service is denied. Please enable it to continue.",
    //     isGranted: false,
    //     status: status
    //   );
    // } else {
    //   return (
    //     error:
    //         "Unknown error occurred with location service. Please ensure it's enabled.",
    //     isGranted: false,
    //     status: status
    //   );
    // }

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return (
        error: "Location services are disabled.",
        isGranted: false,
        status: null
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      if (shouldRequest) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied) {
        return (
          error: "Location service is denied. Please enable it to continue.",
          isGranted: false,
          status: permission
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return (
        error:
            "Location service is permanently denied. Please enable it in settings.",
        isGranted: false,
        status: permission
      );
    }

    return (error: null, isGranted: true, status: permission);
  }

  Future<({String? error, Position? position, bool? hasPermission})>
      getCurrentLocation(
          [LocationAccuracy desiredAccuracy = LocationAccuracy.high]) async {
    try {
      final response =
          await Geolocator.getCurrentPosition(desiredAccuracy: desiredAccuracy);
      AppConfig.setUserLocation(
          lat: response.latitude.toString(),
          long: response.longitude.toString());
      return (error: null, position: response, hasPermission: null);
    } catch (e) {
      final response = await checkLocationPermission(shouldRequest: false);
      if (response.isGranted) {
        return (error: e.toString(), position: null, hasPermission: true);
      }

      return (error: response.error, position: null, hasPermission: false);
    }
  }

  Future<void> clearSavedLocation() async {
    await AppConfig.resetUserLocation();
  }

  Stream<Position> locationStream({
    int distanceFilter = 0,
    LocationAccuracy accuracy = LocationAccuracy.high,
  }) {
    LocationSettings locationSettings = LocationSettings(
      accuracy: accuracy,
      distanceFilter: distanceFilter,
    );

    // return Geolocator.getPositionStream(
    //   locationSettings: locationSettings,
    // );

    Stream<Position> positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    );

    positionStream.listen((Position position) {
      log("UserLocation $position", name: "Location Service");
    });

    return positionStream;
  }

  Future<({String data})> getPlaceNameFromCoordinates(
      double long, double lat) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        lat,
        long,
      );
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        // final String name = '${placemark.name}';
        final String name = '${placemark.locality}';

        return (data: name);
      } else {
        return (data: "UNAVAILABLE");
      }
    } catch (e) {
      return (data: "UNAVAILABLE");
    }
  }

  Future<String?> getPlaceImage({required String locality}) async {
    try {
      final response = await HttpRepository.getPlacePicture(locality);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['results'] != null && data['results'].isNotEmpty) {
          var firstResult = data['results'][0];
          if (firstResult['photos'] != null &&
              firstResult['photos'].isNotEmpty) {
            var photoReference = firstResult['photos'][0]['photo_reference'];
            String photoUrl =
                'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=${AppEnvironment.googleMapsApiKey}';
            return photoUrl;
          }
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<({String? error, List<Placemark>? data})> getPlaceMarkFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      return (error: null, data: placemarks);
    } on PlatformException catch (_) {
      return (
        error:
            "Failed to fetch location. Please check your internet connection, enable location services, and try again.",
        data: null
      );
    } catch (e) {
      return (error: e.toString(), data: null);
    }
  }
}
