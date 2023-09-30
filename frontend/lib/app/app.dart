import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/env/env.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/utils/app_scroll_behavior.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Env.appName,
      theme: FlexThemeData.light(
        scheme: FlexScheme.deepOrangeM3,
        useMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.deepOrangeM3,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: appRouter,
      scrollBehavior: AppScrollBehavior(),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 500, name: MOBILE),
          const Breakpoint(start: 501, end: 1000, name: TABLET),
          const Breakpoint(start: 1001, end: double.infinity, name: DESKTOP),
        ],
      ),
    );
  }
}
