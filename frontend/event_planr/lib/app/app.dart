import 'package:event_planr/app/app_router.dart';
import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.light,
      //darkTheme: AppTheme.dark,
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        FormBuilderLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: mainRouter,
    );
  }
}
