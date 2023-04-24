import 'package:event_planr/domain/event/event.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class EventRepository {
  final events = [
    Event(
      id: '1',
      name: 'Test event',
      category: 'Conference',
      venue: 'Budapest BME',
      startDate: DateTime.now(),
      coverImageUrl:
          const NetworkImage('https://picsum.photos/id/24/200/300.jpg'),
    ),
    Event(
      id: '2',
      name: 'Test event 2',
      category: 'Festival',
      venue: 'Budapest park',
      startDate: DateTime.now(),
      coverImageUrl:
          const NetworkImage('https://picsum.photos/id/28/200/300.jpg'),
    ),
  ];

  final upcoming = [
    Event(
      id: '1',
      name: 'Test event',
      category: 'Conference',
      venue: 'Budapest BME',
      startDate: DateTime.now(),
      coverImageUrl:
          const NetworkImage('https://picsum.photos/id/30/200/300.jpg'),
    ),
  ];

  final invite = [
    Event(
      id: '2',
      name: 'Test event 2',
      category: 'Festival',
      venue: 'Budapest park',
      startDate: DateTime.now(),
      coverImageUrl:
          const NetworkImage('https://picsum.photos/id/40/200/300.jpg'),
    ),
  ];

  final past = [
    Event(
      id: '1',
      name: 'Test event 3',
      category: 'Art',
      venue: 'Budapest Nemzeti Múzeum',
      startDate: DateTime.now(),
      coverImageUrl:
          const NetworkImage('https://picsum.photos/id/50/200/300.jpg'),
    ),
  ];

  Future<List<Event>> listEvents() async {
    return events;
  }

  Future<List<Event>> listMyEvents(MyEventType type) async {
    switch (type) {
      case MyEventType.upcoming:
        return upcoming;
      case MyEventType.invite:
        return invite;
      case MyEventType.past:
        return past;
    }
  }
}
