import 'package:event_planr_app/di/injectable.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class BlocRoute<TCubit extends Cubit<dynamic>> extends GoRoute {
  BlocRoute({
    required super.path,
    required Widget Function(GoRouterState state) builder,
    void Function(TCubit cubit, GoRouterState state)? init,
    List<GoRoute> super.routes = const [],
  }) : super(
          pageBuilder: (context, state) {
            final blocProvider = BlocProvider(
              key: ValueKey(state.fullPath),
              create: (context) {
                final a = injector<TCubit>();
                if (init != null &&
                    state.matchedLocation == state.uri.toString()) {
                  init(a, state);
                }
                return a;
              },
              child: builder(state),
            );

            return context.breakpoints.largerThan(MOBILE)
                ? NoTransitionPage(key: state.pageKey, child: blocProvider)
                : MaterialPage(
                    key: state.pageKey,
                    child: blocProvider,
                  );
          },
        );
}
