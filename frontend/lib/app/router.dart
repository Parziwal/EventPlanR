import 'package:event_planr_app/di/injectable.dart';
import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/ui/auth/cubit/auth_cubit.dart';
import 'package:event_planr_app/ui/auth/view/auth_tab_page.dart';
import 'package:event_planr_app/ui/auth/view/forgot_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PagePaths {
  static String home = '/home';
  static String signIn = '/auth/signIn';
  static String signUp = '/auth/signUp';
  static String forgotPassword = '/auth/forgotPassword';
}

final appRouter = GoRouter(
  initialLocation: PagePaths.signIn,
  routes: [
    GoRoute(
      path: PagePaths.home,
      builder: (s, l) => const Text('Welcome'),
    ),
    BlocRoute<AuthCubit>(
      path: PagePaths.signIn,
      builder: (_) => const AuthTabPage(),
    ),
    BlocRoute<AuthCubit>(
      path: PagePaths.signUp,
      builder: (_) => const AuthTabPage(),
    ),
    BlocRoute<AuthCubit>(
      path: PagePaths.forgotPassword,
      builder: (_) => const ForgotPasswordPage(),
    ),
  ],
  redirect: _appRouterRedirect,
);

class BlocRoute<TCubit extends Cubit<dynamic>> extends GoRoute {
  BlocRoute({
    required super.path,
    required Widget Function(GoRouterState s) builder,
    List<GoRoute> super.routes = const [],
  }) : super(
          builder: (context, state) {
            return BlocProvider(
              create: (context) => injector<TCubit>(),
              child: builder(state),
            );
          },
        );
}

Future<String?> _appRouterRedirect(
  BuildContext context,
  GoRouterState state,
) async {
  final isAuthenticated = await injector<AuthRepository>().isUserSignedIn();
  if (!isAuthenticated && !state.matchedLocation.startsWith('/auth')) {
    return PagePaths.signIn;
  }
  return null;
}
