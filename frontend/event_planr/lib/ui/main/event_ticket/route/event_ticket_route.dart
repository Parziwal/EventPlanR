import 'package:event_planr/di/injectable.dart';
import 'package:event_planr/ui/main/event_ticket/cubit/event_ticket_cubit.dart';
import 'package:event_planr/ui/main/event_ticket/view/event_ticket_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> eventTicketRoute(GlobalKey<NavigatorState>? navigationKey) => [
      GoRoute(
        path: 'event-ticket',
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider<EventTicketCubit>(
            create: (context) => injector<EventTicketCubit>()
              ..getEventTickets(state.pathParameters['eventId']!),
            child: const EventTicketPage(),
          );
        },
        parentNavigatorKey: navigationKey,
      ),
    ];
