import 'package:event_planr_app/data/network/event_planr/models/add_ticket_to_event_command.dart';
import 'package:event_planr_app/data/network/event_planr/models/update_ticket_command.dart';
import 'package:event_planr_app/data/network/event_planr/ticket_manager/ticket_manager_client.dart';
import 'package:event_planr_app/domain/models/ticket/add_or_edit_ticket.dart';
import 'package:injectable/injectable.dart';

@singleton
class TicketManagerRepository {
  TicketManagerRepository({required TicketManagerClient ticketManager})
      : _ticketManager = ticketManager;

  final TicketManagerClient _ticketManager;

  Future<String> addOrEditEventTicket(AddOrEditTicket ticket) async {
    if (ticket.id != null) {
      await _ticketManager.putTicketmanagerTicketId(
        ticketId: ticket.id!,
        body: UpdateTicketCommand(
          price: ticket.price,
          count: ticket.count,
          saleStarts: ticket.saleStarts,
          saleEnds: ticket.saleEnds,
          description: ticket.description,
        ),
      );
      return ticket.id!;
    } else {
      return _ticketManager.postTicketmanagerEventEventId(
        eventId: ticket.eventId!,
        body: AddTicketToEventCommand(
          name: ticket.name!,
          price: ticket.price,
          count: ticket.count,
          saleStarts: ticket.saleStarts,
          saleEnds: ticket.saleEnds,
          description: ticket.description,
        ),
      );
    }
  }

  Future<void> deleteTicket(String ticketId) async {
    await _ticketManager.deleteTicketmanagerTicketId(ticketId: ticketId);
  }
}
