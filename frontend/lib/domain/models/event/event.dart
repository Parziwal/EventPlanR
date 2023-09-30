import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

@freezed
class Event with _$Event {
  const factory Event({
    required String id,
    required String name,
    required String venue,
    required String organizationName,
    required DateTime fromDate,
    required DateTime toDate,
    required ImageProvider coverImage,
  }) = _Event;
}
