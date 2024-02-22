// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class VehicleRentalModel {
  final ValueNotifier<String?> _amountToPayNotifier;
  final ValueNotifier<int> _rentalDaysNotifier;
  final double _pricePerDay;
  DateTime? _startDate;
  DateTime? _endDate;
  String? web3VehicleId;
  String? vehicleId;
  String? lessorID;
  DateTime? rentalStartDateTime;
  DateTime? rentalEndDateTime;
  TimeOfDay? pickUpTime;
  TimeOfDay? returnTime;
  String? rentalId;

  VehicleRentalModel({required double pricePerDay})
      : _pricePerDay = pricePerDay,
        _amountToPayNotifier = ValueNotifier<String?>(null),
        _rentalDaysNotifier = ValueNotifier<int>(1) {
    _calculateAmountToPay();
  }
  String get amountToPay => _amountToPayNotifier.value!;

  ValueNotifier<String?> get amountToPayNotifier => _amountToPayNotifier;
  int get rentalDays => _rentalDaysNotifier.value;
  ValueNotifier<int> get rentalDaysNotifier => _rentalDaysNotifier;

  set rentalDays(int value) {
    if (_rentalDaysNotifier.value != value) {
      _rentalDaysNotifier.value = value;
      _calculateAmountToPay();
    }
  }

  DateTime? get startDate => _startDate;
  set startDate(DateTime? value) {
    _startDate = value;
    _updateRentalDays();
  }

  DateTime? get endDate => _endDate;

  set endDate(DateTime? value) {
    _endDate = value;
    _updateRentalDays();
  }

  void _calculateAmountToPay() {
    _amountToPayNotifier.value =
        (_pricePerDay * _rentalDaysNotifier.value).toStringAsFixed(2);
  }

  void _updateRentalDays() {
    if (_startDate != null && _endDate != null) {
      final difference = _endDate!.difference(_startDate!).inDays;
      rentalDays = difference >= 0 ? difference + 1 : 1;
    } else {
      rentalDays = 1;
    }
  }

  @override
  String toString() {
    return 'VehicleRentalModel(_amountToPayNotifier: $_amountToPayNotifier, _rentalDaysNotifier: $_rentalDaysNotifier, _pricePerDay: $_pricePerDay, _startDate: $_startDate, _endDate: $_endDate, web3VehicleId: $web3VehicleId, vehicleId: $vehicleId, rentalStartDateTime: $rentalStartDateTime, rentalEndDateTime: $rentalEndDateTime, pickUpTime: $pickUpTime, returnTime: $returnTime)';
  }
}
