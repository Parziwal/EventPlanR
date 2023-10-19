import 'package:event_planr_app/data/network/event_planr/models/add_reserve_ticket_dto.dart';
import 'package:event_planr_app/data/network/event_planr/models/add_ticket_user_info_dto.dart';
import 'package:event_planr_app/data/network/event_planr/models/order_reserved_tickets_command.dart';
import 'package:event_planr_app/data/network/event_planr/models/reserve_user_tickets_command.dart';
import 'package:event_planr_app/data/network/event_planr/ticket_order/ticket_order_client.dart';
import 'package:event_planr_app/domain/models/order/order.dart' as model;
import 'package:event_planr_app/domain/models/ticket/add_reserve_ticket.dart';
import 'package:event_planr_app/domain/models/ticket/create_order.dart';
import 'package:event_planr_app/domain/models/ticket/sold_ticket.dart';
import 'package:event_planr_app/utils/domain_extensions.dart';
import 'package:injectable/injectable.dart';

@singleton
class TicketOrderRepository {
  TicketOrderRepository({required TicketOrderClient ticketOrderClient})
      : _ticketOrderClient = ticketOrderClient;

  final TicketOrderClient _ticketOrderClient;

  Future<List<model.Order>> getEventOrder(String eventId) async {
    final eventOrder =
        await _ticketOrderClient.getTicketorderEventId(eventId: eventId);

    return eventOrder
        .map(
          (o) => model.Order(
            customerFirstName: o.customerFirstName,
            customerLastName: o.customerLastName,
            billingAddress: o.billingAddress.toDomainModel(),
            total: o.total,
            currency: o.currency.toDomainEnum(),
            soldTickets: o.soldTickets
                .map(
                  (t) => SoldTicket(
                    id: t.id,
                    userFirstName: t.userFirstName,
                    userLastName: t.userLastName,
                    price: t.price,
                    currency: t.currency.toDomainEnum(),
                    ticketName: t.ticketName,
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  Future<void> reserveTickets(List<AddReserveTicket> tickets) async {
    await _ticketOrderClient.postTicketorderReserve(
      body: ReserveUserTicketsCommand(
        reserveTickets: tickets
            .map(
              (t) => AddReserveTicketDto(ticketId: t.ticketId, count: t.count),
            )
            .toList(),
      ),
    );
  }

  Future<void> orderReservedTickets(CreateOrder order) async {
    await _ticketOrderClient.postTicketorder(
      body: OrderReservedTicketsCommand(
        customerFirstName: order.customerFirstName,
        customerLastName: order.customerLastName,
        billingAddress: order.billingAddress.toNetworkModel(),
        ticketUserInfos: order.ticketUserInfos
            .map(
              (t) => AddTicketUserInfoDto(
                ticketId: t.ticketId,
                userFirstName: t.userFirstName,
                userLastName: t.userLastName,
              ),
            )
            .toList(),
      ),
    );
  }
}
