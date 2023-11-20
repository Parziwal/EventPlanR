import 'package:event_planr_app/domain/models/order/order_details.dart';
import 'package:event_planr_app/domain/ticket_order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'organization_event_order_details_state.dart';

part 'organization_event_order_details_cubit.freezed.dart';

@injectable
class OrganizationEventOrderDetailsCubit
    extends Cubit<OrganizationEventOrderDetailsState> {
  OrganizationEventOrderDetailsCubit({
    required TicketOrderRepository ticketOrderRepository,
  })  : _ticketOrderRepository = ticketOrderRepository,
        super(
          const OrganizationEventOrderDetailsState(
            status: OrganizationEventOrderDetailsStatus.idle,
          ),
        );

  final TicketOrderRepository _ticketOrderRepository;

  Future<void> loadEventOrderDetails(String orderId) async {
    try {
      emit(state.copyWith(status: OrganizationEventOrderDetailsStatus.loading));
      final order = await _ticketOrderRepository
          .getOrganizationEventOrderDetails(orderId);
      emit(state.copyWith(orderDetails: order));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: OrganizationEventOrderDetailsStatus.error,
          exception: e,
        ),
      );
    }

    emit(state.copyWith(status: OrganizationEventOrderDetailsStatus.idle));
  }
}
