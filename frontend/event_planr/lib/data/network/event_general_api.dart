import 'package:event_planr/data/network/models/event_details_dto.dart';
import 'package:event_planr/data/network/models/event_dto.dart';

abstract class EventGeneralApi {
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
}
