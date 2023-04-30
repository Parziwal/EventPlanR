import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class EventFilter extends Equatable {
  const EventFilter({
    this.searchTerm,
    this.category,
    this.fromDate,
    this.toDate,
    this.longitude,
    this.latitude,
    this.radius,
  });

  final String? searchTerm;
  final int? category;
  final DateTime? fromDate;
  final DateTime? toDate;
  final double? longitude;
  final double? latitude;
  final double? radius;

  @override
  List<Object?> get props => [
        searchTerm,
        category,
        fromDate,
        toDate,
        longitude,
        latitude,
        radius,
      ];
}
