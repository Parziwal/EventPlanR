import 'package:dio/dio.dart';
import 'package:event_planr/data/network/event_general_api.dart';
import 'package:event_planr/data/network/event_general_service.dart';
import 'package:event_planr/data/network/message_api.dart';
import 'package:event_planr/data/network/message_service.dart';
import 'package:event_planr/data/network/nominatim_api.dart';
import 'package:event_planr/data/network/nominatim_service.dart';
import 'package:event_planr/data/network/ticket_api.dart';
import 'package:event_planr/data/network/ticket_service.dart';
import 'package:event_planr/domain/auth/auth_repository.dart';
import 'package:event_planr/env/env.dart';
import 'package:graphql/client.dart';
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
    dio.options.headers['authorization'] = authRepository.bearerToken;
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

  @singleton
  MessageApi getMessageApi(Dio dio) {
    return MessageService(dio, baseUrl: Env.MESSAGE_API_URL);
  }

  @singleton
  GraphQLClient getGraphQLClient() {
    Link httpLink = HttpLink(
      Env.CHAT_GRAPHQL_URL,
      defaultHeaders: {'x-api-key': 'da2-ervxxik6jjfo5bulkqr3o6j26q'},
    );

    final websocketLink = WebSocketLink(
      Env.CHAT_GRAPHQL_REALTIME_URL,
      config: const SocketClientConfig(
        headers: {
          'host':
              '2vfd4vxilndbbepk7wbbxsnvfm.appsync-api.us-east-1.amazonaws.com',
          'x-api-key': 'da2-ervxxik6jjfo5bulkqr3o6j26q',
        },
        initialPayload: <String>{},
      ),
    );

    httpLink = Link.split(
      (request) => request.isSubscription,
      websocketLink,
      httpLink,
    );

    final client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    return client;
  }
}
