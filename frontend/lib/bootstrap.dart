import 'dart:async';
import 'dart:developer';

import 'package:event_planr_app/amplify/amplify.dart';
import 'package:event_planr_app/di/injectable.dart';
import 'package:event_planr_app/utils/url_strategy.dart'
  if (dart.library.html) 'package:event_planr_app/utils/web_url_strategy.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  configUrlStrategy();
  await configureDependencies();
  await configureAmplify();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();
  
  runApp(await builder());
}
