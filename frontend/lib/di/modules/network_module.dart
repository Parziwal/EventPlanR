import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:event_planr_app/data/network/event_planr_api/chat_manager/chat_manager_client.dart';
import 'package:event_planr_app/data/network/event_planr_api/event_general/event_general_client.dart';
import 'package:event_planr_app/data/network/event_planr_api/event_invitation/event_invitation_client.dart';
import 'package:event_planr_app/data/network/event_planr_api/event_manager/event_manager_client.dart';
import 'package:event_planr_app/data/network/event_planr_api/news_post/news_post_client.dart';
import 'package:event_planr_app/data/network/event_planr_api/organization_manager/organization_manager_client.dart';
import 'package:event_planr_app/data/network/event_planr_api/ticket_manager/ticket_manager_client.dart';
import 'package:event_planr_app/data/network/event_planr_api/ticket_order/ticket_order_client.dart';
import 'package:event_planr_app/data/network/event_planr_api/user_ticket/user_ticket_client.dart';
import 'package:event_planr_app/data/network/nominatim_api/nominatim_client.dart';
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
          if (await authRepository.isUserSignedIn) {
            options.headers['Authorization'] = await authRepository.bearerToken;
          }
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
  ChatManagerClient getChatManagerClient(Dio dio) {
    return ChatManagerClient(dio, baseUrl: '${Env.eventPlanrApiUrl}/');
  }

  @singleton
  EventInvitationClient getEventInvitationClient(Dio dio) {
    return EventInvitationClient(dio, baseUrl: '${Env.eventPlanrApiUrl}/');
  }

  @singleton
  NominatimClient getNominatimClient(Dio dio) {
    return NominatimClient(dio, baseUrl: '${Env.nominatimApiUrl}/');
  }
}
