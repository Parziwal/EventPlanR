import 'package:event_planr/ui/auth/auth.dart';
import 'package:go_router/go_router.dart';

final GoRouter mainRouter = GoRouter(
  routes: <RouteBase>[
    ...authRoute,
  ],
  initialLocation: '/auth/welcome',
);
