import 'package:event_planr_app/data/network/event_planr_api/models/add_ticket_to_event_command.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/edit_ticket_command.dart';
import 'package:event_planr_app/data/network/event_planr_api/ticket_manager/ticket_manager_client.dart';
import 'package:event_planr_app/domain/models/ticket/add_or_edit_ticket.dart';
import 'package:event_planr_app/domain/models/ticket/organization_ticket.dart';
import 'package:event_planr_app/utils/domain_extensions.dart';
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
        body: EditTicketCommand(
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

  Future<List<OrganizationTicket>> getOrganizationEventTickets(
    String eventId,
  ) async {
    final tickets =
        await _ticketManager.getTicketmanagerEventEventId(eventId: eventId);

    return tickets
        .map(
          (t) => OrganizationTicket(
            created: t.created,
            lastModified: t.lastModified,
            id: t.id,
            name: t.name,
            count: t.count,
            remainingCount: t.remainingCount,
            price: t.price,
            saleStarts: t.saleStarts,
            saleEnds: t.saleEnds,
            currency: t.currency.toDomainEnum(),
            description: t.description,
            lastModifiedBy: t.lastModifiedBy,
            createdBy: t.createdBy,
          ),
        )
        .toList();
  }
}
