import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class BuyTicket extends Equatable {
  const BuyTicket({
    required this.ticketName,
    required this.quantity,
  });

  final String ticketName;
  final int quantity;

  BuyTicket copyWith({
    String Function()? ticketName,
    String Function()? userId,
    int Function()? quantity,
  }) {
    return BuyTicket(
      ticketName: ticketName != null ? ticketName() : this.ticketName,
      quantity: quantity != null ? quantity() : this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        ticketName,
        quantity,
      ];
}
