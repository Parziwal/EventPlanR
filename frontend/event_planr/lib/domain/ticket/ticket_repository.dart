import 'package:event_planr/data/network/event_planr_api.dart';
import 'package:event_planr/data/network/models/buy_ticket_dto.dart';
import 'package:event_planr/domain/auth/auth_repository.dart';
import 'package:event_planr/domain/ticket/models/buy_ticket.dart';
import 'package:event_planr/domain/ticket/models/event_ticket.dart';
import 'package:event_planr/domain/ticket/models/user_ticket.dart';
import 'package:injectable/injectable.dart';

@singleton
class TicketRepository {
  TicketRepository(this.eventPlanrApi, this.authRepository);

  final EventPlanrApi eventPlanrApi;
  final AuthRepository authRepository;

  Future<List<EventTicket>> getEventTickets(String eventId) {
    return eventPlanrApi.getEventTickets(eventId).then(
          (tickets) => tickets
              .map(
                (ticket) => EventTicket(
                  name: ticket.name,
                  price: ticket.price,
                  description: ticket.description,
                ),
              )
              .toList(),
        );
  }

  Future<List<UserTicket>> getUserEvents(String eventId, String userId) {
    return eventPlanrApi.getUserTickets(eventId, userId).then(
          (tickets) => tickets
              .map(
                (ticket) => UserTicket(
                  id: ticket.id,
                  ticketName: ticket.ticketName,
                  quantity: ticket.quantity,
                ),
              )
              .toList(),
        );
  }

  Future<void> buyTicket(String eventId, List<BuyTicket> tickets) async {
    final user = await authRepository.user;
    return eventPlanrApi.buyTickets(
      eventId,
      user.sub,
      tickets
          .map(
            (t) => BuyTicketDto(
              ticketName: t.ticketName,
              quantity: t.quantity,
            ),
          )
          .toList(),
    );
  }
}
