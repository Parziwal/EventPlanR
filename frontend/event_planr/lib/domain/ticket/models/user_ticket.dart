import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserTicket extends Equatable {
  const UserTicket({
    required this.id,
    required this.ticketName,
    required this.quantity,
  });

  final String id;
  final String ticketName;
  final int quantity;

  @override
  List<Object?> get props => [
        id,
        ticketName,
        quantity,
      ];
}
