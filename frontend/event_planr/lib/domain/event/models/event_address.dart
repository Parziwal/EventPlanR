import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class EventAddress extends Equatable {
  const EventAddress({
    required this.venue,
    required this.country,
    required this.zipCode,
    required this.city,
    required this.addressLine,
    required this.longitude,
    required this.latitude,
  });

  final String venue;
  final String country;
  final String zipCode;
  final String city;
  final String addressLine;
  final double longitude;
  final double latitude;

  @override
  List<Object?> get props => [
        venue,
        country,
        zipCode,
        city,
        addressLine,
        longitude,
        latitude,
      ];
}
