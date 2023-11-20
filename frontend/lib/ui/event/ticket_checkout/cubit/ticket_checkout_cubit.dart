import 'package:event_planr_app/domain/models/ticket/add_reserve_ticket.dart';
import 'package:event_planr_app/domain/models/ticket/create_order.dart';
import 'package:event_planr_app/domain/ticket_order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'ticket_checkout_state.dart';

part 'ticket_checkout_cubit.freezed.dart';

@injectable
class TicketCheckoutCubit extends Cubit<TicketCheckoutState> {
  TicketCheckoutCubit({
    required TicketOrderRepository ticketOrderRepository,
  })  : _ticketOrderRepository = ticketOrderRepository,
        super(const TicketCheckoutState(status: TicketCheckoutStatus.idle));

  final TicketOrderRepository _ticketOrderRepository;

  void loadReservedTickets() {
    final reservedTickets = _ticketOrderRepository.getReservedTickets();
    final expirationTime =
        _ticketOrderRepository.getReservedTicketsExpiration();
    emit(
      state.copyWith(
        reservedTickets: reservedTickets,
        expirationTime: expirationTime,
      ),
    );
  }

  Future<void> orderReservedTickets(CreateOrder order) async {
    try {
      emit(state.copyWith(status: TicketCheckoutStatus.loading));
      await _ticketOrderRepository.orderReservedTickets(order);
      emit(state.copyWith(status: TicketCheckoutStatus.ticketsOrdered));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: TicketCheckoutStatus.error,
          exception: e,
        ),
      );
    }

    emit(state.copyWith(status: TicketCheckoutStatus.idle));
  }
}
