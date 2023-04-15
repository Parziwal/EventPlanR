import 'package:event_planr/ui/auth/auth.dart';
import 'package:event_planr/ui/main/navbar/navbar.dart';
import 'package:go_router/go_router.dart';

final GoRouter mainRouter = GoRouter(
  routes: <RouteBase>[
    ...authRoute,
    mainRoute,
  ],
  initialLocation: '/main/home',
);
