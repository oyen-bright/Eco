// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:emr_005/ecomoto/cubit/vehicle_cubit/vehicle_model.dart';
import 'package:emr_005/router/routes/general_routes/notification_routes.dart';
import 'package:emr_005/utils/enums.dart';

class User {
  final String id;
  final String? firstName;
  final String? lastName;
  final String email;
  final bool isEmailVerified;
  final String username;
  final String userType;
  final UserOnboardingStatus? userOnboardingStatus;

  // final List<Notification> notifications;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isEmailVerified,
    required this.username,
    required this.userType,
    required this.userOnboardingStatus,

    // required this.notifications,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'isEmailVerified': isEmailVerified,
      'username': username,
      'userType': userType,
      'userOnboardingStatus': userOnboardingStatus?.value,
      // 'notifications': notifications.map((x) => x.toMap()).toList(),
    };
  }

  factory User.initial() {
    return User(
      id: "",
      firstName: "",
      lastName: "",
      email: "",
      isEmailVerified: false,
      username: "",
      userType: "",
      userOnboardingStatus: null,

      // notifications: [],
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'] as String,
      isEmailVerified: map['isEmailVerified'] as bool,
      username: map['username'],
      userType: map['userType'] as String,
      userOnboardingStatus:
          AppEnums.userOnboardingStatusFromString(map['userOnboardingStatus']),

      //TODO:NOTIFICAATIONS
      // notifications: List<Notification>.from((map['rentals']).map<Rental>(
      //   (x) => Rental.fromMap(x as Map<String, dynamic>),
      // )),
      // notifications: [],

      //TODO:Rentals

      // rentals: List<Rental>.from(
      //   (map['rentals']).map<Rental>(
      //     (x) => Rental.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    bool? isEmailVerified,
    String? username,
    String? userType,
    UserOnboardingStatus? userOnboardingStatus,
    List<Vehicle>? cars,
    List<Notification>? notifications,
    List<Rental>? rentals,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      username: username ?? this.username,
      userType: userType ?? this.userType,
      userOnboardingStatus: userOnboardingStatus ?? this.userOnboardingStatus,

      // notifications: notifications ?? this.notifications,
    );
  }
}

class Rental {
  final String id;
  final String carId;
  final String currentLocation;
  final String destination;
  final String destinationGeoLoc;
  final List escrows;
  final String lesseeId;
  final String pickupAddress;
  final String pickupGeoLoc;
  final DateTime pickupTime;
  final String planId;
  final DateTime rentalEndDatetime;
  final DateTime rentalRequestTime;
  final DateTime rentalStartDatetime;
  final RentalStatus rentalStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Rental({
    required this.id,
    required this.carId,
    required this.currentLocation,
    required this.destination,
    required this.destinationGeoLoc,
    required this.escrows,
    required this.lesseeId,
    required this.pickupAddress,
    required this.pickupGeoLoc,
    required this.pickupTime,
    required this.planId,
    required this.rentalEndDatetime,
    required this.rentalRequestTime,
    required this.rentalStartDatetime,
    required this.rentalStatus,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'carId': carId,
      'currentLocation': currentLocation,
      'destination': destination,
      'destinationGeoLoc': destinationGeoLoc,
      'escrows': escrows,
      'lesseeId': lesseeId,
      'pickupAddress': pickupAddress,
      'pickupGeoLoc': pickupGeoLoc,
      'pickupTime': pickupTime.millisecondsSinceEpoch,
      'planId': planId,
      'rentalEndDatetime': rentalEndDatetime.millisecondsSinceEpoch,
      'rentalRequestTime': rentalRequestTime.millisecondsSinceEpoch,
      'rentalStartDatetime': rentalStartDatetime.millisecondsSinceEpoch,
      'rentalStatus': rentalStatus.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'deletedAt': deletedAt?.millisecondsSinceEpoch,
    };
  }

  factory Rental.fromMap(Map<String, dynamic> map) {
    return Rental(
      id: map['id'] as String,
      carId: map['carId'] as String,
      currentLocation: map['currentLocation'] as String,
      destination: map['destination'] as String,
      destinationGeoLoc: map['destinationGeoLoc'] as String,
      escrows: List.from((map['escrows'] as List)),
      lesseeId: map['lesseeId'] as String,
      pickupAddress: map['pickupAddress'] as String,
      pickupGeoLoc: map['pickupGeoLoc'] as String,
      pickupTime: DateTime.fromMillisecondsSinceEpoch(map['pickupTime'] as int),
      planId: map['planId'] as String,
      rentalEndDatetime:
          DateTime.fromMillisecondsSinceEpoch(map['rentalEndDatetime'] as int),
      rentalRequestTime:
          DateTime.fromMillisecondsSinceEpoch(map['rentalRequestTime'] as int),
      rentalStartDatetime: DateTime.fromMillisecondsSinceEpoch(
          map['rentalStartDatetime'] as int),
      rentalStatus:
          AppEnums.rentalRentalStatusFromString(map['rentalStatus']) ??
              RentalStatus.accepted,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      deletedAt: map['deletedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['deletedAt'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rental.fromJson(String source) =>
      Rental.fromMap(json.decode(source) as Map<String, dynamic>);
}
