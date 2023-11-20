import 'package:event_planr_app/domain/models/order/order_details.dart';
import 'package:event_planr_app/domain/ticket_order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_ticket_order_state.dart';

part 'user_ticket_order_cubit.freezed.dart';

@injectable
class UserTicketOrderCubit extends Cubit<UserTicketOrderState> {
  UserTicketOrderCubit({
    required TicketOrderRepository ticketOrderRepository,
  })  : _ticketOrderRepository = ticketOrderRepository,
        super(const UserTicketOrderState(status: UserTicketOrderStatus.idle));

  final TicketOrderRepository _ticketOrderRepository;

  Future<void> loadUserEventOrders(String eventId) async {
    try {
      emit(state.copyWith(status: UserTicketOrderStatus.loading));
      final orders = await _ticketOrderRepository.getUserEventOrder(
        eventId,
      );
      emit(state.copyWith(orders: orders));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: UserTicketOrderStatus.error,
          exception: e,
        ),
      );
    }

    emit(state.copyWith(status: UserTicketOrderStatus.idle));
  }
}
