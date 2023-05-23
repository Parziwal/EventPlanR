import 'package:event_planr/data/network/models/buy_ticket_dto.dart';
import 'package:event_planr/data/network/models/event_details_dto.dart';
import 'package:event_planr/data/network/models/event_dto.dart';
import 'package:event_planr/data/network/models/event_ticket_dto.dart';
import 'package:event_planr/data/network/models/user_dto.dart';
import 'package:event_planr/data/network/models/user_ticket_dto.dart';

abstract class EventPlanrApi {
  Future<List<EventDto>> getEventList({
    String? searchTerm,
    int? category,
    DateTime? fromDate,
    DateTime? toDate,
    double? longitude,
    double? latitude,
    double? radius,
  });

  Future<EventDetailsDto> getEventDetails(String id);

  Future<List<EventDto>> getUserEvents(String userId);

  Future<List<UserDto>> getUsers();

  Future<List<EventTicketDto>> getEventTickets(String eventId);

  Future<List<UserTicketDto>> getUserTickets(String eventId, String userId);

  Future<void> buyTickets(
    String eventId,
    String userId,
    List<BuyTicketDto> ticket,
  );
}
