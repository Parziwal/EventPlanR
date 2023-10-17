import 'package:event_planr_app/data/network/event_planr_api.dart';
import 'package:event_planr_app/domain/models/common/address.dart';
import 'package:event_planr_app/domain/models/common/coordinates.dart';
import 'package:event_planr_app/domain/models/common/paginated_list.dart';
import 'package:event_planr_app/domain/models/event/event.dart';
import 'package:event_planr_app/domain/models/event/event_details.dart';
import 'package:event_planr_app/domain/models/event/event_filter.dart';
import 'package:event_planr_app/domain/models/news_post/news_post.dart';
import 'package:event_planr_app/domain/models/organization/organization.dart';
import 'package:event_planr_app/domain/models/organization/organization_details.dart';
import 'package:injectable/injectable.dart';

@singleton
class EventGeneralRepository {
  EventGeneralRepository({required EventPlanrApi eventPlanrApi})
      : _eventPlanrApi = eventPlanrApi;

  final EventPlanrApi _eventPlanrApi;

  Future<PaginatedList<Event>> getFilteredEvents(EventFilter filter) async {
    final events = await _eventPlanrApi.getFilteredEvents(
      searchTerm: filter.searchTerm,
      category: filter.category,
      currency: filter.currency,
      fromDate: filter.fromDate,
      toDate: filter.toDate,
      longitude: filter.longitude,
      latitude: filter.latitude,
      radius: filter.radius,
      pageNumber: filter.pageNumber ?? 1,
      pageSize: filter.pageSize ?? 10,
      orderBy: filter.orderBy,
      orderDirection: filter.orderDirection,
    );

    return PaginatedList<Event>(
      items: events.items.map(Event.fromJson).toList(),
      pageNumber: events.pageNumber,
      totalPages: events.totalPages,
      totalCount: events.totalCount,
      hasPreviousPage: events.hasPreviousPage,
      hasNextPage: events.hasNextPage,
    );
  }

  Future<EventDetails> getEventDetails(String eventId) async {
    final event = await _eventPlanrApi.getEventDetails(eventId);

    return EventDetails(
      id: event.id,
      name: event.name,
      description: event.description,
      coverImageUrl: event.coverImageUrl,
      category: event.category,
      fromDate: event.fromDate,
      toDate: event.toDate,
      venue: event.venue,
      address: Address(
        country: event.address.country,
        city: event.address.city,
        zipCode: event.address.zipCode,
        addressLine: event.address.addressLine,
      ),
      coordinates: Coordinates(
        latitude: event.coordinates.latitude,
        longitude: event.coordinates.longitude,
      ),
      organization: Organization(
        id: event.organization.id,
        name: event.organization.name,
        profileImageUrl: event.organization.profileImageUrl,
      ),
      latestNews: NewsPost(
        text: event.latestNews.text,
        created: event.latestNews.created,
      ),
    );
  }

  Future<PaginatedList<Organization>> getOrganizations(
      String? searchTerm) async {
    final organizations =
        await _eventPlanrApi.getOrganizations(searchTerm: searchTerm);

    return PaginatedList<Organization>(
      items: organizations.items.map(Organization.fromJson).toList(),
      pageNumber: organizations.pageNumber,
      totalPages: organizations.totalPages,
      totalCount: organizations.totalCount,
      hasPreviousPage: organizations.hasPreviousPage,
      hasNextPage: organizations.hasNextPage,
    );
  }

  Future<OrganizationDetails> getOrganizationDetails(
    String organizationId,
  ) async {
    final organization =
        await _eventPlanrApi.getOrganizationDetails(organizationId);

    return OrganizationDetails(
      id: organization.id,
      name: organization.name,
      profileImageUrl: organization.profileImageUrl,
      description: organization.description,
    );
  }
}
