import 'package:flutter/material.dart';

@immutable
class Event {
  const Event({
    required this.id,
    required this.name,
    required this.category,
    required this.venue,
    required this.startDate,
    required this.coverImageUrl,
  });

  final String id;
  final String name;
  final String category;
  final String venue;
  final DateTime startDate;
  final ImageProvider coverImageUrl;
}
