import 'package:beamer/beamer.dart';
import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/theme/theme.dart';
import 'package:event_planr/ui/auth/auth.dart';
import 'package:flutter/material.dart';

final beamerLocationBuilder = BeamerLocationBuilder(
  beamLocations: [
    AuthLocation(),
  ],
);

class App extends StatelessWidget {
  App({super.key});

  final routerDelegate = BeamerDelegate(
    locationBuilder: beamerLocationBuilder.call,
    initialPath: '/auth',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.light,
      //darkTheme: AppTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
    );
  }
}
