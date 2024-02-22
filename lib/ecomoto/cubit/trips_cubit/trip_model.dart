// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:emr_005/utils/enums.dart';

import '../vehicle_cubit/vehicle_model.dart';

class Trip {
  Vehicle carDetails;

  DateTime createdAt;
  String currentLocation;
  String id;
  String destination;
  String destinationGeoLoc;
  String pickupAddress;
  String pickupGeoLoc;
  Map<String, dynamic>? lessor;
  Map<String, dynamic>? lessee;
  String startMillage;
  DateTime pickupTime;
  DateTime rentalEndDatetime;
  DateTime rentalRequestTime;
  DateTime rentalStartDatetime;
  RentalStatus? rentalStatus;

  Trip({
    required this.id,
    required this.carDetails,
    required this.createdAt,
    required this.currentLocation,
    required this.destination,
    required this.destinationGeoLoc,
    required this.pickupAddress,
    required this.pickupGeoLoc,
    required this.startMillage,
    required this.lessor,
    required this.lessee,
    required this.pickupTime,
    required this.rentalEndDatetime,
    required this.rentalRequestTime,
    required this.rentalStartDatetime,
    required this.rentalStatus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'carDetails': carDetails.toMap(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'currentLocation': currentLocation,
      'id': id,
      'startMillage': startMillage,
      'lessor': lessor,
      'destination': destination,
      'destinationGeoLoc': destinationGeoLoc,
      'pickupAddress': pickupAddress,
      'pickupGeoLoc': pickupGeoLoc,
      'pickupTime': pickupTime.millisecondsSinceEpoch,
      'rentalEndDatetime': rentalEndDatetime.millisecondsSinceEpoch,
      'rentalRequestTime': rentalRequestTime.millisecondsSinceEpoch,
      'rentalStartDatetime': rentalStartDatetime.millisecondsSinceEpoch,
      'rentalStatus': rentalStatus?.value,
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    //TODO return locatino to rental
    return Trip(
        startMillage: map['startMillage'],
        lessor: {
          'username': map['lessor']['username'],
          'id': map['lessor']['id'],
          'firstName': map['lessor']['firstName'],
          'lastName': map['lessor']['lastName'],
          'email': map['lessor']['email']
        },
        lessee: {
          'username': map['lessee']['username'],
          'id': map['lessee']['id'],
          'firstName': map['lessee']['firstName'],
          'lastName': map['lessee']['lastName'],
          'email': map['lessee']['email']
        },
        carDetails: Vehicle.fromMap(map['car'] as Map<String, dynamic>),
        createdAt: DateTime.parse(map['createdAt'] as String),
        currentLocation: map['currentLocation'] as String,
        id: map['id'] as String,
        destination: map['destination'] as String,
        destinationGeoLoc: map['destinationGeoLoc'] as String,
        pickupAddress: map['pickupAddress'] as String,
        pickupGeoLoc: map['pickupGeoLoc'] as String,
        pickupTime: DateTime.parse(map['pickupTime'] as String),
        rentalEndDatetime: DateTime.parse(map['rentalEndDatetime'] as String),
        rentalRequestTime: DateTime.parse(map['rentalRequestTime'] as String),
        rentalStartDatetime:
            DateTime.parse(map['rentalStartDatetime'] as String),
        rentalStatus: map['rentalStatus'] != null
            ? AppEnums.rentalRentalStatusFromString(
                map['rentalStatus'] as String)
            : null);
  }

  String toJson() => json.encode(toMap());

  factory Trip.fromJson(String source) =>
      Trip.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Trip.dummy() {
    return Trip(
        startMillage: "",
        lessor: {},
        lessee: {},
        id: 'id',
        carDetails: Vehicle.dummy(),
        createdAt: DateTime.now(),
        currentLocation: 'currentLocation',
        destination: 'destination',
        destinationGeoLoc: 'destinationGeoLoc',
        pickupAddress: 'pickUpAddress',
        pickupGeoLoc: 'pickupGeoLoc',
        pickupTime: DateTime.now(),
        rentalEndDatetime: DateTime.now().add(const Duration(days: 100)),
        rentalRequestTime: DateTime.now(),
        rentalStartDatetime: DateTime.now(),
        rentalStatus: RentalStatus.active);
  }

  Trip copyWith({
    Vehicle? carDetails,
    DateTime? createdAt,
    String? currentLocation,
    String? id,
    String? destination,
    String? destinationGeoLoc,
    String? pickupAddress,
    String? pickupGeoLoc,
    Map<String, dynamic>? lessor,
    Map<String, dynamic>? lessee,
    String? startMillage,
    DateTime? pickupTime,
    DateTime? rentalEndDatetime,
    DateTime? rentalRequestTime,
    DateTime? rentalStartDatetime,
    RentalStatus? rentalStatus,
  }) {
    return Trip(
      carDetails: carDetails ?? this.carDetails,
      createdAt: createdAt ?? this.createdAt,
      currentLocation: currentLocation ?? this.currentLocation,
      id: id ?? this.id,
      destination: destination ?? this.destination,
      destinationGeoLoc: destinationGeoLoc ?? this.destinationGeoLoc,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      pickupGeoLoc: pickupGeoLoc ?? this.pickupGeoLoc,
      lessor: lessor ?? this.lessor,
      lessee: lessee ?? this.lessee,
      startMillage: startMillage ?? this.startMillage,
      pickupTime: pickupTime ?? this.pickupTime,
      rentalEndDatetime: rentalEndDatetime ?? this.rentalEndDatetime,
      rentalRequestTime: rentalRequestTime ?? this.rentalRequestTime,
      rentalStartDatetime: rentalStartDatetime ?? this.rentalStartDatetime,
      rentalStatus: rentalStatus ?? this.rentalStatus,
    );
  }
}

class CarDetails {
  List<Map<String, dynamic>> carImages;
  String color;
  String id;
  Map<String, dynamic> lessorId;
  String make;
  String model;
  String vehicleBrand;
  String vehicleType;

  CarDetails({
    required this.carImages,
    required this.color,
    required this.id,
    required this.lessorId,
    required this.make,
    required this.model,
    required this.vehicleBrand,
    required this.vehicleType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'carImages': carImages,
      'color': color,
      'id': id,
      'lessorId': lessorId,
      'make': make,
      'model': model,
      'vehicleBrand': vehicleBrand,
      'vehicleType': vehicleType,
    };
  }

  factory CarDetails.fromMap(Map<String, dynamic> map) {
    return CarDetails(
      carImages: List<Map<String, dynamic>>.from((map['carImages'] as List)),
      color: map['color'] as String,
      id: map['id'] as String,
      lessorId:
          Map<String, dynamic>.from((map['lessorId'] as Map<String, dynamic>)),
      make: map['make'] as String,
      model: map['model'] as String,
      vehicleBrand: map['vehicleBrand'] as String,
      vehicleType: map['vehicleType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarDetails.fromJson(String source) =>
      CarDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CarDetails.dummy() {
    return CarDetails(
        carImages: [],
        color: 'color',
        id: 'id',
        lessorId: {
          "username": "username",
          "id": "id",
          "firstName": "firstname",
          "lastName": "lastname",
          "email": "email"
        },
        make: 'make',
        model: 'model',
        vehicleBrand: 'vehicleBrand',
        vehicleType: 'vehicleType');
  }
}
