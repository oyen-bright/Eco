// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VehicleQueryOptions {
  final List<String>? brand;
  final List<String>? type;
  final List<String>? capacity;
  final String? min;
  final String? max;

  VehicleQueryOptions({
    this.brand,
    this.type,
    this.capacity,
    this.min,
    this.max,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brand': brand,
      'type': type,
      'capacity': capacity,
      'min': min,
      'max': max,
    };
  }

  factory VehicleQueryOptions.fromMap(Map<String, dynamic> map) {
    return VehicleQueryOptions(
      brand: map['brand'] != null
          ? List<String>.from((map['brand'] as List<String>))
          : null,
      type: map['type'] != null
          ? List<String>.from((map['type'] as List<String>))
          : null,
      capacity: map['capacity'] != null
          ? List<String>.from((map['capacity'] as List<String>))
          : null,
      min: map['min'] != null ? map['min'] as String : null,
      max: map['max'] != null ? map['max'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleQueryOptions.fromJson(String source) =>
      VehicleQueryOptions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VehicleQueryOptions(brand: $brand, type: $type, capacity: $capacity, min: $min, max: $max)';
  }
}
