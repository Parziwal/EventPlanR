import 'package:dio/dio.dart';
import 'package:event_planr_app/data/network/event_planr_api.dart';
import 'package:event_planr_app/data/network/event_planr_client.dart';
import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/env/env.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio getDio(AuthRepository authRepository) {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Authorization'] = await authRepository.bearerToken;
          return handler.next(options);
        },
        onError: (e, handler) {
          if (e.response?.statusCode == 400) {

          } else if (e.response?.statusCode == 403) {
            
          } else if (e.response?.statusCode == 404) {

          }

          return handler.next(e);
        },
      ),
    );
    return dio;
  }

  @singleton
  EventPlanrApi getEventPlanrApi(Dio dio) {
    return EventPlanrClient(dio, baseUrl: '${Env.eventPlanrApiUrl}/');
  }
}
