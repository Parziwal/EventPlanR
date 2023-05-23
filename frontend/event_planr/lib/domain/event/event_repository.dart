import 'package:event_planr/data/network/event_planr_api.dart';
import 'package:event_planr/domain/auth/auth_repository.dart';
import 'package:event_planr/domain/event/event.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class EventRepository {
  EventRepository(this.eventPlanrApi, this.authRepository);

  final EventPlanrApi eventPlanrApi;
  final AuthRepository authRepository;

  final upcoming = [
    Event(
      id: '1',
      name: 'Test event',
      category: EventCategory.conference,
      venue: 'Budapest BME',
      fromDate: DateTime.now(),
      coverImageUrl:
          const NetworkImage('https://picsum.photos/id/30/200/300.jpg'),
    ),
  ];

  final invite = [
    Event(
      id: '2',
      name: 'Test event 2',
      category: EventCategory.entertainment,
      venue: 'Budapest park',
      fromDate: DateTime.now(),
      coverImageUrl:
          const NetworkImage('https://picsum.photos/id/40/200/300.jpg'),
    ),
  ];

  final past = [
    Event(
      id: '1',
      name: 'Test event 3',
      category: EventCategory.cultural,
      venue: 'Budapest Nemzeti Múzeum',
      fromDate: DateTime.now(),
      coverImageUrl:
          const NetworkImage('https://picsum.photos/id/50/200/300.jpg'),
    ),
  ];

  Future<List<Event>> getEventList(EventFilter filter) async {
    final events = await eventPlanrApi.getEventList(
      searchTerm: filter.searchTerm,
      category: filter.category,
      fromDate: filter.fromDate,
      toDate: filter.toDate,
      longitude: filter.longitude,
      latitude: filter.latitude,
      radius: filter.radius,
    );
    return events
        .map(
          (e) => Event(
            id: e.id,
            name: e.name,
            category: EventCategory.values[e.category - 1],
            venue: e.venue,
            fromDate: e.fromDate,
            coverImageUrl:
                NetworkImage(e.coverImageUrl ?? 'https://placehold.co/600x400'),
          ),
        )
        .toList();
  }

  Future<EventDetails> getEventDetails(String id) async {
    final event = await eventPlanrApi.getEventDetails(id);
    return EventDetails(
      id: event.id,
      name: event.name,
      category: EventCategory.values[event.category],
      fromDate: event.fromDate,
      toDate: event.toDate,
      address: EventAddress(
        venue: event.address.venue,
        country: event.address.country,
        city: event.address.city,
        zipCode: event.address.zipCode,
        addressLine: event.address.addressLine,
        longitude: event.address.longitude,
        latitude: event.address.latitude,
      ),
      description: event.description,
      coverImageUrl:
          NetworkImage(event.coverImageUrl ?? 'https://placehold.co/600x400'),
      isPrivate: event.isPrivate,
    );
  }

  Future<List<Event>> listMyEvents(UserEventType type) async {
    switch (type) {
      case UserEventType.upcoming:
        return _getUserEvents();
      case UserEventType.invite:
        return invite;
      case UserEventType.past:
        return past;
    }
  }

  Future<List<Event>> _getUserEvents() async {
    final user = await authRepository.user;
    final events = await eventPlanrApi.getUserEvents(user.sub);
    return events
        .map(
          (e) => Event(
            id: e.id,
            name: e.name,
            category: EventCategory.values[e.category - 1],
            venue: e.venue,
            fromDate: e.fromDate,
            coverImageUrl:
                NetworkImage(e.coverImageUrl ?? 'https://placehold.co/600x400'),
          ),
        )
        .toList();
  }
}
