// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:emr_005/ecomoto/cubit/vehicle_cubit/smart_car_vehicle_model.dart';

class VehicleModel {
  String? vin;
  String? brand;
  String? model;
  String? modelYear;
  int? numberOfSeats;
  String? color;
  int? capacity;
  String? vehicleType;
  int? mileagePerCharge;
  String? vehiclePlateNumber;
  String? vehicleRegistrationGoodThru;

  String? insuranceProvider;
  int? insurancePNumber;
  int? policyNumber;
  SmartCarVehicle? smartCarVehicle;
  DateTime? effectiveDate;
  DateTime? expiryDate;
  List<String>? extraFeatures;
  bool isReserved = false;
  bool isPublicParking = false;
  int? pricePerHour;

  int? minimumPrice;
  int? maximumPrice;
  List<DateTime>? selectedDates;
  bool isUpToDate = false;
  bool isRegisteredOwner = false;
  bool isVehicleMaintenance = false;
  bool isAccident = false;
  List<String>? images;
  String? insuranceImage;

  double? latitude;
  double? longitude;

  List<String>? vehicleImageUrl;
  List<String>? vehicleVideoUrl;

  String? vehicleId;

  // @override
  // String toString() {
  //   return 'VehicleInputData('
  //       'vin: $vin, '
  //       'brand: $brand, '
  //       'model: $model, '
  //       'modelYear: $modelYear, '
  //       'numberOfSeats: $numberOfSeats, '
  //       'color: $color, '
  //       'capacity: $capacity, '
  //       'vehicleType: $vehicleType, '
  //       'mileagePerCharge: $mileagePerCharge, '
  //       'insuranceProvider: $insuranceProvider, '
  //       'insurancePNumber: $insurancePNumber, '
  //       'policyNumber: $policyNumber, '
  //       'effectiveDate: $effectiveDate, '
  //       'expiryDate: $expiryDate, '
  //       'extraFeatures: $extraFeatures, '
  //       'isReserved: $isReserved, '
  //       'isPublicParking: $isPublicParking, '
  //       'pricePerHour: $pricePerHour, '
  //       'selectedDates: $selectedDates, '
  //       'isMaintained: $isUpToDate, '
  //       'isRegisteredOwner: $isRegisteredOwner, '
  //       'isVehicleMaintenance: $isVehicleMaintenance, '
  //       'isAccident: $isAccident, '
  //       'images: $images, '
  //       'latitude: $latitude, '
  //       'longitude: $longitude'
  //       'imageUrl : $vehicleImageUrl'
  //       'videoUrl : $vehicleVideoUrl'
  //       'vehicleId : $vehicleId'
  //       ')';
  // }

  @override
  String toString() {
    return 'VehicleModel(vin: $vin, brand: $brand, model: $model, modelYear: $modelYear, numberOfSeats: $numberOfSeats, color: $color, capacity: $capacity, vehicleType: $vehicleType, mileagePerCharge: $mileagePerCharge, insuranceProvider: $insuranceProvider, insurancePNumber: $insurancePNumber, policyNumber: $policyNumber, smartCarVehicle: $smartCarVehicle, effectiveDate: $effectiveDate, expiryDate: $expiryDate, extraFeatures: $extraFeatures, isReserved: $isReserved, isPublicParking: $isPublicParking, pricePerHour: $pricePerHour, selectedDates: $selectedDates, isUpToDate: $isUpToDate, isRegisteredOwner: $isRegisteredOwner, isVehicleMaintenance: $isVehicleMaintenance, isAccident: $isAccident, images: $images, latitude: $latitude, longitude: $longitude, vehicleImageUrl: $vehicleImageUrl, vehicleVideoUrl: $vehicleVideoUrl, vehicleId: $vehicleId)';
  }
}
