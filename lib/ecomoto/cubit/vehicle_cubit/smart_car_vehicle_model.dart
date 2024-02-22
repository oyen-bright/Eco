// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SmartCarVehicle {
  final String id;
  final String vin;
  final String make;
  final LatLng location;
  final double odometer;
  final ({int range, String percentRemaining}) battery;
  final ({String access, String refresh})? token;
  final String batteryCapacity;
  final ({String state, bool isPluggedIn}) chargingStatus;
  final String model;
  final String year;
  SmartCarVehicle({
    required this.token,
    required this.vin,
    required this.odometer,
    required this.id,
    required this.location,
    required this.battery,
    required this.batteryCapacity,
    required this.chargingStatus,
    required this.make,
    required this.model,
    required this.year,
  });

  @override
  String toString() {
    return 'SmartCarVehicle(id: $id, vin: $vin, make: $make, location: $location, batteryCapacity: $batteryCapacity, model: $model, year: $year, token:$token)';
  }
}
