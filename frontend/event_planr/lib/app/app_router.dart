import 'package:event_planr/di/injectable.dart';
import 'package:event_planr/domain/auth/auth_repository.dart';
import 'package:event_planr/ui/auth/auth.dart';
import 'package:event_planr/ui/main/navbar/navbar.dart';
import 'package:event_planr/ui/organization/event/route/event_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter mainRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: <RouteBase>[
    ...authRoute,
    mainRoute,
    ...organizationEventRoute
  ],
  initialLocation: '/auth',
  redirect: (BuildContext context, GoRouterState state) async {
      final isAuthenticated = await injector<AuthRepository>().isAuthenticated;
      if (!isAuthenticated && !state.location.startsWith('/auth')) {
        return '/auth';
      }

      return null;
    },
);
