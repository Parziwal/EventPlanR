import 'package:event_planr_app/data/network/event_planr_api/models/add_ticket_to_event_command.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/edit_ticket_command.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/ticket_check_in_command.dart';
import 'package:event_planr_app/data/network/event_planr_api/ticket_manager/ticket_manager_client.dart';
import 'package:event_planr_app/domain/models/common/paginated_list.dart';
import 'package:event_planr_app/domain/models/ticket/add_or_edit_ticket.dart';
import 'package:event_planr_app/domain/models/ticket/check_in_ticket.dart';
import 'package:event_planr_app/domain/models/ticket/check_in_ticket_details.dart';
import 'package:event_planr_app/domain/models/ticket/check_in_ticket_filter.dart';
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
            created: t.created.toLocal(),
            lastModified: t.lastModified.toLocal(),
            id: t.id,
            name: t.name,
            count: t.count,
            remainingCount: t.remainingCount,
            price: t.price,
            saleStarts: t.saleStarts.toLocal(),
            saleEnds: t.saleEnds.toLocal(),
            currency: t.currency.toDomainEnum(),
            description: t.description,
            lastModifiedBy: t.lastModifiedBy,
            createdBy: t.createdBy,
          ),
        )
        .toList();
  }

  Future<PaginatedList<CheckInTicket>> getOrganizationEvenCheckInTickets(
    CheckInTicketFilter filter,
  ) async {
    final tickets = await _ticketManager.getTicketmanagerEventCheckinEventId(
      eventId: filter.eventId,
      pageNumber: filter.pageNumber,
      pageSize: filter.pageSize,
    );

    return PaginatedList(
      items: tickets.items
          .map(
            (t) => CheckInTicket(
              id: t.id,
              userFirstName: t.userFirstName,
              userLastName: t.userLastName,
              ticketName: t.ticketName,
              isCheckedIn: t.isCheckedIn,
            ),
          )
          .toList(),
      pageNumber: tickets.pageNumber,
      totalPages: tickets.totalPages,
      totalCount: tickets.totalCount,
      hasPreviousPage: tickets.hasPreviousPage,
      hasNextPage: tickets.hasNextPage,
    );
  }

  Future<CheckInTicketDetails> getCheckInTicketDetails(
    String soldTicketId,
  ) async {
    final ticket = await _ticketManager.getTicketmanagerCheckinSoldTicketId(
      soldTicketId: soldTicketId,
    );

    return CheckInTicketDetails(
      id: ticket.id,
      userFirstName: ticket.userFirstName,
      userLastName: ticket.userLastName,
      ticketName: ticket.ticketName,
      isCheckedIn: ticket.isCheckedIn,
      price: ticket.price,
      currency: ticket.currency.toDomainEnum(),
      orderId: ticket.orderId,
      created: ticket.created.toLocal(),
    );
  }

  Future<CheckInTicket> ticketCheckIn({
    required String soldTicketId,
    required bool checkIn,
  }) async {
    final ticket = await _ticketManager.postTicketmanagerCheckinSoldTicketId(
      soldTicketId: soldTicketId,
      body: TicketCheckInCommand(checkIn: checkIn),
    );

    return CheckInTicket(
      id: ticket.id,
      userFirstName: ticket.userFirstName,
      userLastName: ticket.userLastName,
      ticketName: ticket.ticketName,
      isCheckedIn: ticket.isCheckedIn,
    );
  }
}
