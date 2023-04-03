import 'package:event_planr/home/home.dart';
import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/main_navigation/view/main_navigation_page.dart';
import 'package:event_planr/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MainNavigationPage(),
    );
  }
}
