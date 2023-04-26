import 'package:event_planr/ui/main/event_details/event_details.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> eventDetialsRoute(GlobalKey<NavigatorState>? navigationKey) => [
  GoRoute(
    path: 'event-details',
    builder: (BuildContext context, GoRouterState state) {
      return const EventDetailsPage();
    },
    parentNavigatorKey: navigationKey,
  ),
];
