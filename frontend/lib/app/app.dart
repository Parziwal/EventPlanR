import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class App extends StatelessWidget {
  const App({required this.appName, super.key});
  final String appName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appName,
      theme: FlexThemeData.light(
        scheme: FlexScheme.deepOrangeM3,
        useMaterial3: true,
      ),
      darkTheme: FlexThemeData.light(
        scheme: FlexScheme.deepOrangeM3,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: appRouter,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: double.infinity, name: DESKTOP),
        ],
      ),
    );
  }
}
