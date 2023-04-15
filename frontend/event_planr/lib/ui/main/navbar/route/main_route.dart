import 'package:event_planr/ui/main/event/event.dart';
import 'package:event_planr/ui/main/explore/explore.dart';
import 'package:event_planr/ui/main/home/home.dart';
import 'package:event_planr/ui/main/message/message.dart';
import 'package:event_planr/ui/main/navbar/view/bottom_navigation_view.dart';
import 'package:event_planr/ui/main/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final mainRoute = ShellRoute(
  builder: (BuildContext context, GoRouterState state, Widget child) {
    return BottomNavigationView(child: child);
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/main/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/main/explore',
      builder: (BuildContext context, GoRouterState state) {
        return const ExplorePage();
      },
    ),
    GoRoute(
      path: '/main/event',
      builder: (BuildContext context, GoRouterState state) {
        return const EventPage();
      },
    ),
    GoRoute(
      path: '/main/message',
      builder: (BuildContext context, GoRouterState state) {
        return const MessagePage();
      },
    ),
    GoRoute(
      path: '/main/profile',
      builder: (BuildContext context, GoRouterState state) {
        return const ProfilePage();
      },
    ),
  ],
);
