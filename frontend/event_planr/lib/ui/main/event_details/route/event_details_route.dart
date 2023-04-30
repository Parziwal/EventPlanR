import 'package:event_planr/di/injectable.dart';
import 'package:event_planr/ui/main/event_details/cubit/event_details_cubit.dart';
import 'package:event_planr/ui/main/event_details/event_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> eventDetialsRoute(GlobalKey<NavigatorState>? navigationKey) => [
      GoRoute(
        path: 'event-details/:eventId',
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => injector<EventDetailsCubit>()
              ..getEventDetail(state.params['eventId']!),
            child: const EventDetailsPage(),
          );
        },
        parentNavigatorKey: navigationKey,
      ),
    ];
