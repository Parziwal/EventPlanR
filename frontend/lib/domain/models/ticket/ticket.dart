import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket.freezed.dart';

@freezed
class Ticket with _$Ticket {
  const factory Ticket({
    required String name,
    required double price,
    required int count,
    required DateTime saleStarts,
    required DateTime saleEnds,
    String? description,
  }) = _Ticket;
}
