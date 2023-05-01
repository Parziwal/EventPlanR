import 'package:event_planr/ui/organization/event/view/event_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> organizationEventRoute = [
  GoRoute(
    path: '/organization/event',
    builder: (BuildContext context, GoRouterState state) {
      return const EventPage();
    },
  ),
];
