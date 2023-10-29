import 'package:event_planr_app/data/network/event_planr/event_general/event_general_client.dart';
import 'package:event_planr_app/domain/models/common/paginated_list.dart';
import 'package:event_planr_app/domain/models/event/event.dart';
import 'package:event_planr_app/domain/models/event/event_category_enum.dart';
import 'package:event_planr_app/domain/models/event/event_details.dart';
import 'package:event_planr_app/domain/models/event/event_distance_enum.dart';
import 'package:event_planr_app/domain/models/event/event_filter.dart';
import 'package:event_planr_app/domain/models/news_post/news_post.dart';
import 'package:event_planr_app/domain/models/news_post/news_post_filter.dart';
import 'package:event_planr_app/domain/models/organization/organization.dart';
import 'package:event_planr_app/domain/models/organization/organization_details.dart';
import 'package:event_planr_app/domain/models/ticket/ticket.dart';
import 'package:event_planr_app/utils/domain_extensions.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@singleton
class EventGeneralRepository {
  EventGeneralRepository({required EventGeneralClient eventGeneralClient})
      : _eventGeneralClient = eventGeneralClient;

  final EventGeneralClient _eventGeneralClient;

  Future<PaginatedList<Event>> getFilteredEvents(EventFilter filter) async {
    final events = await _eventGeneralClient.getEventgeneral(
      searchTerm: filter.searchTerm,
      category:
          filter.category != null ? filter.category!.toNetworkEnum() : null,
      currency:
          filter.currency != null ? filter.currency!.toNetworkEnum() : null,
      fromDate: filter.fromDate,
      toDate: filter.toDate,
      object0: filter.latitude,
      object1: filter.longitude,
      object2: filter.latitude == null
          ? null
          : switch (filter.distance) {
              EventDistanceEnum.km5 => 5000,
              EventDistanceEnum.km10 => 10000,
              EventDistanceEnum.km20 => 20000,
              EventDistanceEnum.km50 => 50000,
              EventDistanceEnum.km100 => 100000,
              null => null,
            },
      pageNumber: filter.pageNumber ?? 1,
      pageSize: filter.pageSize ?? 20,
      orderBy: filter.orderBy.name,
      orderDirection: filter.orderDirection.toNetworkEnum(),
    );

    return PaginatedList<Event>(
      items: events.items
          .map(
            (e) => Event(
              id: e.id,
              name: e.name,
              coverImageUrl: e.coverImageUrl,
              venue: e.venue,
              organizationName: e.organizationName,
              fromDate: e.fromDate,
              toDate: e.toDate,
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

  Future<EventDetails> getEventDetails(String eventId) async {
    final event =
        await _eventGeneralClient.getEventgeneralEventId(eventId: eventId);

    return EventDetails(
      id: event.id,
      name: event.name,
      description: event.description,
      coverImageUrl: event.coverImageUrl,
      category: EventCategoryEnum.values.byName(event.category.name),
      fromDate: event.fromDate,
      toDate: event.toDate,
      venue: event.venue,
      address: event.address.toDomainModel(),
      coordinates:
          LatLng(event.coordinate.latitude, event.coordinate.longitude),
      organization: Organization(
        id: event.organization.id,
        name: event.organization.name,
        profileImageUrl: event.organization.profileImageUrl,
      ),
      latestNews: event.latestNews != null
          ? NewsPost(
              id: event.latestNews!.id,
              title: event.latestNews!.title,
              text: event.latestNews!.text,
              lastModified: event.latestNews!.lastModified,
            )
          : null,
    );
  }

  Future<PaginatedList<Organization>> getOrganizations(
    String? searchTerm,
  ) async {
    final organizations = await _eventGeneralClient.getEventgeneralOrganization(
      searchTerm: searchTerm,
    );

    return PaginatedList<Organization>(
      items: organizations.items
          .map(
            (o) => Organization(
              id: o.id,
              name: o.name,
              profileImageUrl: o.profileImageUrl,
            ),
          )
          .toList(),
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
        await _eventGeneralClient.getEventgeneralOrganizationOrganizationId(
      organizationId: organizationId,
    );

    return OrganizationDetails(
      id: organization.id,
      name: organization.name,
      profileImageUrl: organization.profileImageUrl,
      description: organization.description,
    );
  }

  Future<List<Ticket>> getEventTickets(String eventId) async {
    final tickets = await _eventGeneralClient.getEventgeneralTicketEventId(
      eventId: eventId,
    );

    return tickets
        .map(
          (t) => Ticket(
            id: t.id,
            name: t.name,
            price: t.price,
            currency: t.currency.toDomainEnum(),
            remainingCount: t.remainingCount,
            saleEnds: t.saleEnds,
            description: t.description,
          ),
        )
        .toList();
  }

  Future<PaginatedList<NewsPost>> getEventNewsPosts(
    NewsPostFilter filter,
  ) async {
    final news = await _eventGeneralClient.getEventgeneralNewspostEventId(
      eventId: filter.eventId,
      pageNumber: filter.pageNumber ?? 1,
      pageSize: filter.pageSize ?? 20,
    );

    return PaginatedList(
      items: news.items
          .map(
            (n) => NewsPost(
              id: n.id,
              title: n.title,
              text: n.text,
              lastModified: n.lastModified,
            ),
          )
          .toList(),
      pageNumber: news.pageNumber,
      totalPages: news.totalPages,
      totalCount: news.totalCount,
      hasPreviousPage: news.hasPreviousPage,
      hasNextPage: news.hasNextPage,
    );
  }
}
