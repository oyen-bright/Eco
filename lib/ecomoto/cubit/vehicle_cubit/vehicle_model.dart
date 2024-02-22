// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Vehicle {
  final String id;
  final String make;
  final String vehicleType;
  final String? vin;
  final String model;
  final String color;
  final String year;
  final String? plateNumber;
  final int capacity;
  final int millagePerCharge;
  final int pricePerHour;

  final List<String> extraFeatures;
  final List<DateTime> availableDates;
  final List<Map> carImages;
  final Map<String, dynamic>? parkedLocation;
  final Map<String, dynamic>? web3Data;
  final String? lessorID;
  final ({
    String? id,
  }) smartCarDetails;

  Vehicle({
    this.plateNumber,
    required this.id,
    required this.make,
    this.lessorID,
    required this.model,
    required this.color,
    required this.year,
    required this.capacity,
    required this.vin,
    required this.vehicleType,
    required this.millagePerCharge,
    required this.pricePerHour,
    required this.smartCarDetails,
    this.availableDates = const [],
    required this.web3Data,
    required this.extraFeatures,
    required this.carImages,
    required this.parkedLocation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'make': make,
      'plateNumber': plateNumber,
      'vin': vin,
      'vehicleType': vehicleType,
      'model': model,
      'color': color,
      'year': year,
      'capacity': capacity,
      'availableDates': availableDates,
      'millagePerCharge': millagePerCharge,
      'pricePerHour': pricePerHour,
      'extraFeatures': extraFeatures,
      'carImages{imageUrl}': carImages,
      'parkedLocation': parkedLocation,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    List<Map> updateUrlsToNull(List<Map> carImages) {
      if (carImages.isEmpty) {
        return [];
      }
      return carImages.map((carImage) {
        if (carImage['imageUrl'] == '') {
          carImage['imageUrl'] = null;
        }

        if (carImage['videoUrl'] == '') {
          carImage['videoUrl'] = null;
        }

        return carImage;
      }).toList();
    }

    final carImages =
        updateUrlsToNull(List<Map>.from((map['carImages']) ?? []));

    final allDates = ((map['availability'] as List?) ?? [])
        .map((e) => DateTime.tryParse(e))
        .where((date) => date != null)
        .cast<DateTime>()
        .toList();
    final reservedDates = ((map['reservedDates'] as List?) ?? [])
        .map((e) => DateTime.tryParse(e))
        .where((date) => date != null)
        .cast<DateTime>()
        .toList();

    final availableDates =
        allDates.where((element) => !reservedDates.contains(element)).toList();

    return Vehicle(
      smartCarDetails: (id: map['smartCarVehicleId'] as String?,),
      lessorID: map['lessor']['id'] as String?,
      id: map['id'] as String,
      vehicleType: map['vehicleType'] as String,
      make: map['make'] as String,
      vin: map['vin'] != null ? map['vin'] as String : null,
      model: map['model'] as String,
      color: map['color'] as String,
      year: map['year'] as String,
      availableDates: availableDates,
      plateNumber: map['vehiclePlateNumber'] as String?,
      capacity: map['seats'] as int,
      web3Data: map['web3Data'] as Map<String, dynamic>?,
      millagePerCharge: (map['millagePerCharge'] ?? 0) as int,
      pricePerHour: (map['pricePerHour'] ?? 0) as int,
      extraFeatures: List<String>.from(map['extraFeatures']),
      parkedLocation: map['parkedLocation'] != null
          ? map['parkedLocation'] as Map<String, dynamic>
          : null,
      carImages: carImages,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle.fromJson(String source) =>
      Vehicle.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Vehicle.dummy() {
    return Vehicle(
      id: 'id',
      smartCarDetails: (id: "null",),
      vehicleType: 'vehicleType',
      web3Data: {},
      make: 'make',
      model: 'model',
      color: 'color',
      year: 'year',
      capacity: 0,
      vin: 'vin',
      millagePerCharge: 0,
      pricePerHour: 0,
      extraFeatures: [],
      carImages: [],
      parkedLocation: {},
    );
  }

  @override
  String toString() {
    return 'Vehicle(id: $id, make: $make, vehicleType: $vehicleType, vin: $vin, model: $model, color: $color, year: $year, plateNumber: $plateNumber, capacity: $capacity, millagePerCharge: $millagePerCharge, pricePerHour: $pricePerHour, extraFeatures: $extraFeatures, availableDates: $availableDates, carImages: $carImages, parkedLocation: $parkedLocation, web3Data: $web3Data, lessorID: $lessorID)';
  }
}
