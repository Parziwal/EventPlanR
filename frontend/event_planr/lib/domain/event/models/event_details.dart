import 'package:equatable/equatable.dart';
import 'package:event_planr/domain/event/models/event_address.dart';
import 'package:event_planr/domain/event/models/event_category.dart';
import 'package:flutter/material.dart';

@immutable
class EventDetails extends Equatable {
  const EventDetails({
    required this.id,
    required this.name,
    required this.category,
    required this.fromDate,
    required this.toDate,
    required this.address,
    required this.description,
    required this.coverImageUrl,
    required this.isPrivate,
  });

  final String id;
  final String name;
  final EventCategory category;
  final DateTime fromDate;
  final DateTime toDate;
  final EventAddress address;
  final String? description;
  final ImageProvider coverImageUrl;
  final bool isPrivate;

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        fromDate,
        toDate,
        address,
        description,
        coverImageUrl,
        isPrivate,
      ];
}
