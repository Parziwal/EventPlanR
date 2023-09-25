import 'package:event_planr_app/di/injectable.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final injector = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => injector.init();
