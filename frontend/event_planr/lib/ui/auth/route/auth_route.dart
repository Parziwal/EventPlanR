import 'package:event_planr/di/injectable.dart';
import 'package:event_planr/ui/auth/auth.dart';
import 'package:event_planr/ui/auth/view/confirm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      return BlocProvider(
        create: (context) => injector<AuthCubit>(),
        child: const LoginPage(),
      );
    },
  ),
  GoRoute(
    path: '/auth/signup',
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        create: (context) => injector<AuthCubit>(),
        child: const SignUpPage(),
      );
    },
  ),
  GoRoute(
    path: '/auth/confirm',
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        create: (context) => injector<AuthCubit>(),
        child: const ConfirmPage(),
      );
    },
  ),
];
