import 'package:event_planr_app/data/network/models/event_planr/event/event_details_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/event/event_dto.dart';

abstract class EventPlanrApi {
  Future<List<EventDto>> getFilteredEvents({
    String? searchTerm,
    int? category,
    int? language,
    int? currency,
    DateTime? fromDate,
    DateTime? toDate,
    double? longitude,
    double? latitude,
    double? radius,
    int pageNumber,
    int pageSize,
    String? orderBy,
    int? orderDirection,
  });
  Future<EventDetailsDto> getEventDetails(String eventId);
}
