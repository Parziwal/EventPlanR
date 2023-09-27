import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme {
    return Theme.of(this);
  }

  MediaQueryData get mediaQuery {
    return MediaQuery.of(this);
  }

  ResponsiveBreakpointsData get breakpoints {
    return ResponsiveBreakpoints.of(this);
  }

  GoRouter get goRouter {
    return GoRouter.of(this);
  }

  GoRouterState get goRouterState {
    return GoRouterState.of(this);
  }

  NavigatorState get navigator {
    return Navigator.of(this);
  }

  ScaffoldMessengerState get scaffoldMessenger {
    return ScaffoldMessenger.of(this);
  }
}
