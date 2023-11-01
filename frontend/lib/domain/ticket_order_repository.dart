import 'dart:convert';

import 'package:event_planr_app/data/disk/persistent_store.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/add_reserve_ticket_dto.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/add_ticket_user_info_dto.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/order_reserved_tickets_command.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/reserve_user_tickets_command.dart';
import 'package:event_planr_app/data/network/event_planr_api/ticket_order/ticket_order_client.dart';
import 'package:event_planr_app/domain/models/order/order_details.dart';
import 'package:event_planr_app/domain/models/ticket/add_reserve_ticket.dart';
import 'package:event_planr_app/domain/models/ticket/create_order.dart';
import 'package:event_planr_app/domain/models/ticket/sold_ticket.dart';
import 'package:event_planr_app/utils/domain_extensions.dart';
import 'package:injectable/injectable.dart';

@singleton
class TicketOrderRepository {
  TicketOrderRepository({
    required TicketOrderClient ticketOrderClient,
    required PersistentStore persistentStore,
  })  : _persistentStore = persistentStore,
        _ticketOrderClient = ticketOrderClient;

  final TicketOrderClient _ticketOrderClient;
  final PersistentStore _persistentStore;
  List<AddReserveTicket> _reservedTickets = [];
  DateTime? _reservedTicketsExpiration;

  List<AddReserveTicket> getReservedTickets() {
    if (_reservedTickets.isEmpty) {
      _reservedTickets = _persistentStore.getList(
        'reservedTickets',
        (list) => list.map(AddReserveTicket.fromJson).toList(),
      );
    }

    return _reservedTickets;
  }

  DateTime? getReservedTicketsExpiration() {
    return _reservedTicketsExpiration ??= _persistentStore.getValue(
      'reservedTicketsExpiration',
      DateTime.parse,
    );
  }

  Future<List<OrderDetails>> getEventOrder(String eventId) async {
    final eventOrder =
        await _ticketOrderClient.getTicketorderEventId(eventId: eventId);

    return eventOrder
        .map(
          (o) => OrderDetails(
            id: o.id,
            customerFirstName: o.customerFirstName,
            customerLastName: o.customerLastName,
            billingAddress: o.billingAddress.toDomainModel(),
            total: o.total,
            currency: o.currency.toDomainEnum(),
            created: o.created,
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
    final expirationTime = await _ticketOrderClient.postTicketorderReserve(
      body: ReserveUserTicketsCommand(
        reserveTickets: tickets
            .map(
              (t) => AddReserveTicketDto(ticketId: t.ticketId, count: t.count),
            )
            .toList(),
      ),
    );

    _reservedTickets = tickets;
    _reservedTicketsExpiration =
        DateTime.parse(jsonDecode(expirationTime) as String);
    await _persistentStore.save('reservedTickets', tickets);
    await _persistentStore.save(
      'reservedTicketsExpiration',
      jsonDecode(expirationTime) as String,
    );
  }

  Future<void> orderReservedTickets(CreateOrder order) async {
    await _ticketOrderClient.postTicketorder(
      body: OrderReservedTicketsCommand(
        customerFirstName: order.firstName,
        customerLastName: order.lastName,
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

    await _persistentStore.remove('reservedTickets');
    await _persistentStore.remove('reservedTicketsExpiration');
  }
}
