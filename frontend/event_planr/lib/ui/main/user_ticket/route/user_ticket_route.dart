import 'package:event_planr/di/injectable.dart';
import 'package:event_planr/ui/main/user_ticket/cubit/user_ticket_cubit.dart';
import 'package:event_planr/ui/main/user_ticket/view/user_ticket_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> userTicketRoute(GlobalKey<NavigatorState>? navigationKey) => [
      GoRoute(
        path: 'user-ticket/:eventId',
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider<UserTicketCubit>(
            create: (context) => injector<UserTicketCubit>()
              ..getUserTickets(state.params['eventId']!),
            child: const UserTicketPage(),
          );
        },
        parentNavigatorKey: navigationKey,
      ),
    ];
