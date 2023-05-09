import 'package:event_planr/data/network/models/buy_ticket_dto.dart';
import 'package:event_planr/data/network/models/event_ticket_dto.dart';
import 'package:event_planr/data/network/models/user_ticket_dto.dart';

abstract class TicketApi {
  Future<List<EventTicketDto>> getEventTickets(String eventId);

  Future<List<UserTicketDto>> getUserTickets(String eventId, String userId);

  Future<void> buyTickets(
    String eventId,
    String userId,
    List<BuyTicketDto> ticket,
  );
}
