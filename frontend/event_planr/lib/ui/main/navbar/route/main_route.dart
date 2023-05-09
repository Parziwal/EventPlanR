import 'package:event_planr/app/app_router.dart';
import 'package:event_planr/di/injectable.dart';
import 'package:event_planr/ui/main/chat/chat.dart';
import 'package:event_planr/ui/main/event/event.dart';
import 'package:event_planr/ui/main/event_details/route/event_details_route.dart';
import 'package:event_planr/ui/main/explore/explore.dart';
import 'package:event_planr/ui/main/home/home.dart';
import 'package:event_planr/ui/main/message/message.dart';
import 'package:event_planr/ui/main/navbar/navbar.dart';
import 'package:event_planr/ui/main/profile/profile.dart';
import 'package:event_planr/ui/main/user_ticket/route/user_ticket_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final mainRoute = ShellRoute(
  builder: (BuildContext context, GoRouterState state, Widget child) {
    return BottomNavigationView(child: child);
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/main/home',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: '/main/explore',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => injector<ExploreCubit>()..listEvents(),
          child: const ExplorePage(),
        );
      },
      routes: [...eventDetialsRoute(rootNavigatorKey)],
    ),
    GoRoute(
      path: '/main/event',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => injector<EventCubit>()..listMyEvents(),
          child: const EventPage(),
        );
      },
      routes: [...userTicketRoute(rootNavigatorKey)],
    ),
    GoRoute(
      path: '/main/message',
      builder: (BuildContext context, GoRouterState state) {
        return const MessagePage();
      },
      routes: [...chatRoute(rootNavigatorKey)],
    ),
    GoRoute(
      path: '/main/profile',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => injector<ProfileCubit>(),
          child: const ProfilePage(),
        );
      },
    ),
  ],
);
