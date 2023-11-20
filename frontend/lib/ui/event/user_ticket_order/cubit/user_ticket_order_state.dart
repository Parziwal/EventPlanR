part of 'user_ticket_order_cubit.dart';

enum UserTicketOrderStatus { idle, loading, error }

@freezed
class UserTicketOrderState with _$UserTicketOrderState {
  const factory UserTicketOrderState({
    required UserTicketOrderStatus status,
    @Default([])
    List<OrderDetails> orders,
    Exception? exception,
  }) = _UserTicketOrderState;
}
