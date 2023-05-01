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

  EventFilter copyWith({
    String? Function()? searchTerm,
    int? Function()? category,
    DateTime? Function()? fromDate,
    DateTime? Function()? toDate,
    double? Function()? longitude,
    double? Function()? latitude,
    double? Function()? radius,
  }) {
    return EventFilter(
      searchTerm: searchTerm != null ? searchTerm() : this.searchTerm,
      category: category != null ? category() : this.category,
      fromDate: fromDate != null ? fromDate() : this.fromDate,
      toDate: toDate != null ? toDate() : this.toDate,
      longitude: longitude != null ? longitude() : this.longitude,
      latitude: latitude != null ? latitude() : this.latitude,
      radius: radius != null ? radius() : this.radius,
    );
  }

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
