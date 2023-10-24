import 'package:event_planr_app/data/network/event_planr/event_manager/event_manager_client.dart';
import 'package:event_planr_app/data/network/event_planr/models/create_event_command.dart';
import 'package:event_planr_app/data/network/event_planr/models/edit_event_command.dart';
import 'package:event_planr_app/domain/models/common/paginated_list.dart';
import 'package:event_planr_app/domain/models/event/create_or_edit_event.dart';
import 'package:event_planr_app/domain/models/event/organization_event.dart';
import 'package:event_planr_app/domain/models/event/organization_event_details.dart';
import 'package:event_planr_app/domain/models/event/organization_event_filter.dart';
import 'package:event_planr_app/utils/domain_extensions.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@singleton
class EventManagerRepository {
  EventManagerRepository({required EventManagerClient eventManagerClient})
      : _eventManagerClient = eventManagerClient;

  final EventManagerClient _eventManagerClient;

  Future<PaginatedList<OrganizationEvent>> getOrganizationDraftEvents(
    OrganizationEventFilter filter,
  ) async {
    final events = await _eventManagerClient.getEventmanagerDraft(
      searchTerm: filter.searchTerm,
      pageNumber: filter.pageNumber,
      pageSize: filter.pageSize,
    );

    return PaginatedList(
      items: events.items
          .map(
            (e) => OrganizationEvent(
              id: e.id,
              name: e.name,
              coverImageUrl: e.coverImageUrl,
              fromDate: e.fromDate,
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

  Future<PaginatedList<OrganizationEvent>> getOrganizationPastEvents(
    OrganizationEventFilter filter,
  ) async {
    final events = await _eventManagerClient.getEventmanagerPast(
      searchTerm: filter.searchTerm,
      pageNumber: filter.pageNumber,
      pageSize: filter.pageSize,
    );

    return PaginatedList(
      items: events.items
          .map(
            (e) => OrganizationEvent(
              id: e.id,
              name: e.name,
              coverImageUrl: e.coverImageUrl,
              fromDate: e.fromDate,
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

  Future<PaginatedList<OrganizationEvent>> getOrganizationUpcomingEvents(
    OrganizationEventFilter filter,
  ) async {
    final events = await _eventManagerClient.getEventmanagerUpcoming(
      searchTerm: filter.searchTerm,
      pageNumber: filter.pageNumber,
      pageSize: filter.pageSize,
    );

    return PaginatedList(
      items: events.items
          .map(
            (e) => OrganizationEvent(
              id: e.id,
              name: e.name,
              coverImageUrl: e.coverImageUrl,
              fromDate: e.fromDate,
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

  Future<OrganizationEventDetails> getOrganizationEventDetails(
    String eventId,
  ) async {
    final event =
        await _eventManagerClient.getEventmanagerEventId(eventId: eventId);

    return OrganizationEventDetails(
      id: event.id,
      name: event.name,
      category: event.category.toDomainEnum(),
      fromDate: event.fromDate,
      toDate: event.toDate,
      venue: event.venue,
      address: event.address.toDomainModel(),
      coordinates: LatLng(
        event.coordinate.latitude,
        event.coordinate.longitude,
      ),
      currency: event.currency.toDomainEnum(),
      isPrivate: event.isPrivate,
      isPublished: event.isPublished,
      coverImageUrl: event.coverImageUrl,
      description: event.description,
      created: event.created,
      createdBy: event.createdBy,
      lastModified: event.lastModified,
      lastModifiedBy: event.lastModifiedBy,
    );
  }

  Future<String> createOrEditEvent(CreateOrEditEvent event) async {
    if (event.id != null) {
      await _eventManagerClient.putEventmanagerEventId(
        eventId: event.id!,
        body: EditEventCommand(
          description: event.description,
          category: event.category.toNetworkEnum(),
          fromDate: event.fromDate,
          toDate: event.toDate,
          venue: event.venue,
          address: event.address.toNetworkModel(),
          coordinate: event.coordinates.toNetworkModel(),
          currency: event.currency.toNetworkEnum(),
          isPrivate: event.isPrivate,
        ),
      );
      return event.id!;
    } else {
      return _eventManagerClient.postEventmanager(
        body: CreateEventCommand(
          name: event.name!,
          description: event.description,
          category: event.category.toNetworkEnum(),
          fromDate: event.fromDate,
          toDate: event.toDate,
          venue: event.venue,
          address: event.address.toNetworkModel(),
          coordinate: event.coordinates.toNetworkModel(),
          currency: event.currency.toNetworkEnum(),
          isPrivate: event.isPrivate,
        ),
      );
    }
  }

  Future<void> deleteEvent(String eventId) async {
    await _eventManagerClient.deleteEventmanagerEventId(eventId: eventId);
  }

  Future<void> publishEvent({
    required String eventId,
    required bool publish,
  }) async {
    if (publish) {
      await _eventManagerClient.postEventmanagerPublishEventId(
        eventId: eventId,
      );
    } else {
      await _eventManagerClient.putEventmanagerUnpublishEventId(
        eventId: eventId,
      );
    }
  }
}
