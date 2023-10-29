import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:event_planr_app/data/network/event_planr/event_general/event_general_client.dart';
import 'package:event_planr_app/data/network/event_planr/event_manager/event_manager_client.dart';
import 'package:event_planr_app/data/network/event_planr/news_post/news_post_client.dart';
import 'package:event_planr_app/data/network/event_planr/organization_manager/organization_manager_client.dart';
import 'package:event_planr_app/data/network/event_planr/ticket_manager/ticket_manager_client.dart';
import 'package:event_planr_app/data/network/event_planr/ticket_order/ticket_order_client.dart';
import 'package:event_planr_app/data/network/event_planr/user_ticket/user_ticket_client.dart';
import 'package:event_planr_app/data/network/nominatim/nominatim_client.dart';
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
          options.contentType = Headers.jsonContentType;
          options.headers['Authorization'] = await authRepository.bearerToken;
          return handler.next(options);
        },
        onError: (e, handler) {
          if (e.response?.statusCode == 400) {

          } else if (e.response?.statusCode == 403) {
            
          } else if (e.response?.statusCode == 404) {

          }
          safePrint(e.response);
          return handler.next(e);
        },
      ),
    );
    return dio;
  }

  @singleton
  EventGeneralClient getEventGeneralClient(Dio dio) {
    return EventGeneralClient(dio, baseUrl: '${Env.eventPlanrApiUrl}/');
  }

  @singleton
  EventManagerClient getEventManagerClient(Dio dio) {
    return EventManagerClient(dio, baseUrl: '${Env.eventPlanrApiUrl}/');
  }

  @singleton
  OrganizationManagerClient getOrganizationManagerClient(Dio dio) {
    return OrganizationManagerClient(dio, baseUrl: '${Env.eventPlanrApiUrl}/');
  }

  @singleton
  TicketManagerClient getTicketManagerClient(Dio dio) {
    return TicketManagerClient(dio, baseUrl: '${Env.eventPlanrApiUrl}/');
  }

  @singleton
  TicketOrderClient getTicketOrderClient(Dio dio) {
    return TicketOrderClient(dio, baseUrl: '${Env.eventPlanrApiUrl}/');
  }

  @singleton
  UserTicketClient getUserTicketClient(Dio dio) {
    return UserTicketClient(dio, baseUrl: '${Env.eventPlanrApiUrl}/');
  }

  @singleton
  NewsPostClient getNewsPostClient(Dio dio) {
    return NewsPostClient(dio, baseUrl: '${Env.eventPlanrApiUrl}/');
  }

  @singleton
  NominatimClient getNominatimClient(Dio dio) {
    return NominatimClient(dio, baseUrl: '${Env.nominatimApiUrl}/');
  }
}
