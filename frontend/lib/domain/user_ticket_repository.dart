import 'package:event_planr_app/data/network/event_planr/user_ticket/user_ticket_client.dart';
import 'package:event_planr_app/domain/models/common/paginated_list.dart';
import 'package:event_planr_app/domain/models/event/event.dart';
import 'package:event_planr_app/domain/models/ticket/sold_ticket.dart';
import 'package:event_planr_app/utils/domain_extensions.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserTicketRepository {
  UserTicketRepository({required UserTicketClient userTicketClient})
      : _userTicketClient = userTicketClient;

  final UserTicketClient _userTicketClient;

  Future<PaginatedList<Event>> getUserUpcomingEvents() async {
    final events = await _userTicketClient.getUserticketUpcoming();

    return PaginatedList(
      items: events.items
          .map(
            (e) => Event(
              id: e.id,
              name: e.name,
              venue: e.venue,
              organizationName: e.organizationName,
              fromDate: e.fromDate,
              toDate: e.toDate,
              coverImageUrl: e.coverImageUrl,
            ),
          )
          .toList(),
      pageNumber: events.pageNumber,
      totalPages: events.totalPages,
      totalCount: events.totalCount,
      hasPreviousPage: events.hasPreviousPage,
      hasNextPage: events.hasNextPage,
    );
  }

  Future<PaginatedList<Event>> getUserEventInvitations() async {
    final events = await _userTicketClient.getUserticketInvitation();

    return PaginatedList(
      items: events.items
          .map(
            (e) => Event(
              id: e.id,
              name: e.name,
              venue: e.venue,
              organizationName: e.organizationName,
              fromDate: e.fromDate,
              toDate: e.toDate,
              coverImageUrl: e.coverImageUrl,
            ),
          )
          .toList(),
      pageNumber: events.pageNumber,
      totalPages: events.totalPages,
      totalCount: events.totalCount,
      hasPreviousPage: events.hasPreviousPage,
      hasNextPage: events.hasNextPage,
    );
  }

  Future<PaginatedList<Event>> getUserPastEvents() async {
    final events = await _userTicketClient.getUserticketPast();

    return PaginatedList(
      items: events.items
          .map(
            (e) => Event(
              id: e.id,
              name: e.name,
              venue: e.venue,
              organizationName: e.organizationName,
              fromDate: e.fromDate,
              toDate: e.toDate,
              coverImageUrl: e.coverImageUrl,
            ),
          )
          .toList(),
      pageNumber: events.pageNumber,
      totalPages: events.totalPages,
      totalCount: events.totalCount,
      hasPreviousPage: events.hasPreviousPage,
      hasNextPage: events.hasNextPage,
    );
  }

  Future<List<SoldTicket>> getUserEventTickets(String eventId) async {
    final tickets =
        await _userTicketClient.getUserticketEventId(eventId: eventId);

    return tickets
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
        .toList();
  }
}