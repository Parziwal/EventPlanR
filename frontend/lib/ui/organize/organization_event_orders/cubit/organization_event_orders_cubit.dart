import 'package:event_planr_app/domain/models/order/event_order.dart';
import 'package:event_planr_app/domain/models/order/organization_event_orders_filter.dart';
import 'package:event_planr_app/domain/ticket_order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'organization_event_orders_state.dart';

part 'organization_event_orders_cubit.freezed.dart';

@injectable
class OrganizationEventOrdersCubit extends Cubit<OrganizationEventOrdersState> {
  OrganizationEventOrdersCubit({
    required TicketOrderRepository ticketOrderRepository,
  })  : _ticketOrderRepository = ticketOrderRepository,
        super(const OrganizationEventOrdersState());

  final TicketOrderRepository _ticketOrderRepository;

  Future<void> getEventOrders({
    required String eventId,
    required int pageNumber,
  }) async {
    try {
      emit(
        state.copyWith(
          eventOrders: pageNumber == 1 ? null : state.eventOrders,
        ),
      );
      final orders = await _ticketOrderRepository.getOrganizationEventOrders(
        OrganizationEventOrdersFilter(
          eventId: eventId,
          pageNumber: pageNumber,
          pageSize: 20,
        ),
      );
      emit(
        state.copyWith(
          eventOrders: pageNumber == 1
              ? orders.items
              : [...state.eventOrders!, ...orders.items],
          pageNumber: orders.hasNextPage ? pageNumber + 1 : null,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          exception: e,
        ),
      );
    }
  }
}
