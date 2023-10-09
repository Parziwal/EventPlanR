import 'package:event_planr_app/di/injectable.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class BlocRoute<TCubit extends Cubit<dynamic>> extends GoRoute {
  BlocRoute({
    required super.path,
    required Widget Function(GoRouterState s) builder,
    TCubit Function(TCubit cubit, GoRouterState s)? init,
    List<GoRoute> super.routes = const [],
  }) : super(
          pageBuilder: (context, state) =>
              context.breakpoints.largerThan(MOBILE)
                  ? NoTransitionPage(
                      key: state.pageKey,
                      child: BlocProvider(
                        key: state.pageKey,
                        create: (context) => init != null
                            ? init(injector<TCubit>(), state)
                            : injector<TCubit>(),
                        child: builder(state),
                      ),
                    )
                  : MaterialPage(
                      key: state.pageKey,
                      child: BlocProvider(
                        key: state.pageKey,
                        create: (context) => init != null
                            ? init(injector<TCubit>(), state)
                            : injector<TCubit>(),
                        child: builder(state),
                      ),
                    ),
        );
}
