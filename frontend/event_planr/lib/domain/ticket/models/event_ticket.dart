import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class EventTicket extends Equatable {
  const EventTicket({
    required this.name,
    required this.price,
    required this.description,
  });

  final String name;
  final double price;
  final String description;

  @override
  List<Object?> get props => [
        name,
        price,
        description,
      ];
}
