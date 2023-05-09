import 'package:dio/dio.dart';
import 'package:event_planr/data/network/event_general_api.dart';
import 'package:event_planr/data/network/event_general_service.dart';
import 'package:event_planr/data/network/nominatim_api.dart';
import 'package:event_planr/data/network/nominatim_service.dart';
import 'package:event_planr/data/network/ticket_api.dart';
import 'package:event_planr/data/network/ticket_service.dart';
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
    dio.options.baseUrl = Env.EVENT_GENERAL_API_URL;
    dio.options.headers['authorization'] =
        authRepository.bearerToken;
    dio.interceptors.add(LogInterceptor());
    return dio;
  }

  @singleton
  EventGeneralApi getEventGeneralApi(Dio dio) {
    return EventGeneralService(dio, baseUrl: Env.EVENT_GENERAL_API_URL);
  }

  @singleton
  TicketApi getTicketApi(Dio dio) {
    return TicketService(dio, baseUrl: Env.TICKET_API_URL);
  }

  @singleton
  NominatimApi getNominatimApi(Dio dio) {
    dio.options.headers.clear();
    return NominatimService(dio, baseUrl: Env.NOMINATIM_API_URL);
  }
}
