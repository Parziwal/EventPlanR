import 'package:event_planr/ui/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final authRoute = [
  GoRoute(
    path: '/auth/welcome',
    builder: (BuildContext context, GoRouterState state) {
      return const WelcomePage();
    },
  ),
  GoRoute(
    path: '/auth/login',
    builder: (BuildContext context, GoRouterState state) {
      return const LoginPage();
    },
  ),
  GoRoute(
    path: '/auth/signup',
    builder: (BuildContext context, GoRouterState state) {
      return const SignUpPage();
    },
  ),
];
