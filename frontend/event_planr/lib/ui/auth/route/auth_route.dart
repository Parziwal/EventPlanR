import 'package:event_planr/di/injectable.dart';
import 'package:event_planr/ui/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final authRoute = [
  GoRoute(
    path: '/auth',
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        create: (context) => injector<AuthCubit>()..autoLogin(),
        child: const WelcomePage(),
      );
    },
    routes: [
      GoRoute(
        path: 'login',
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => injector<AuthCubit>(),
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: 'signup',
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => injector<AuthCubit>(),
            child: const SignUpPage(),
          );
        },
      ),
    ],
  ),
  GoRoute(
    path: '/auth/confirm-registration',
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        create: (context) => injector<AuthCubit>(),
        child: const ConfirmRegistrationPage(),
      );
    },
  ),
  GoRoute(
    path: '/auth/forgot-password',
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        create: (context) => injector<AuthCubit>(),
        child: const ForgotPasswordPage(),
      );
    },
  ),
  GoRoute(
    path: '/auth/new-password',
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider(
        create: (context) => injector<AuthCubit>(),
        child: const NewPasswordPage(),
      );
    },
  ),
];
