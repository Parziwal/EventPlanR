import 'package:equatable/equatable.dart';
import 'package:event_planr/domain/event/models/event_category.dart';
import 'package:flutter/material.dart';

@immutable
class Event extends Equatable {
  const Event({
    required this.id,
    required this.name,
    required this.category,
    required this.venue,
    required this.fromDate,
    required this.coverImageUrl,
  });

  final String id;
  final String name;
  final EventCategory category;
  final String venue;
  final DateTime fromDate;
  final ImageProvider coverImageUrl;

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        venue,
        fromDate,
        coverImageUrl,
      ];
}
