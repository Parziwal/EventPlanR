import 'package:dio/dio.dart';
import 'package:event_planr/data/network/event_planr_api.dart';
import 'package:event_planr/data/network/event_planr_service.dart';
import 'package:event_planr/data/network/nominatim_api.dart';
import 'package:event_planr/data/network/nominatim_service.dart';
import 'package:event_planr/domain/auth/auth_repository.dart';
import 'package:event_planr/env/env.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class DiModule {
  @preResolve
  @singleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  Dio getDio(AuthRepository authRepository) {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Authorization'] = await authRepository.bearerToken;
          handler.next(options);
        },
      ),
    );
    return dio;
  }

  @singleton
  EventPlanrApi getEventPlanrApi(Dio dio) {
    return EventPlanrService(dio, baseUrl: Env.EVENT_PLANR_API_URL);
  }

  @singleton
  NominatimApi getNominatimApi(Dio dio) {
    dio.options.headers.clear();
    return NominatimService(dio, baseUrl: Env.NOMINATIM_API_URL);
  }
}
