import 'package:envied/envied.dart';

part 'env.g.dart';
// ignore_for_file: constant_identifier_names

@Envied(path: '.env')
abstract class Env {
  @EnviedField()
  static const COGNITO_USER_POOL_ID = _Env.COGNITO_USER_POOL_ID;
  @EnviedField()
  static const COGNITO_CLIENT_ID = _Env.COGNITO_CLIENT_ID;
  @EnviedField()
  static const EVENT_GENERAL_API_URL = _Env.EVENT_GENERAL_API_URL;
  @EnviedField()
  static const TICKET_API_URL = _Env.TICKET_API_URL;
  @EnviedField()
  static const MESSAGE_API_URL = _Env.MESSAGE_API_URL;
  @EnviedField()
  static const CHAT_GRAPHQL_URL = _Env.CHAT_GRAPHQL_URL;
  @EnviedField()
  static const CHAT_GRAPHQL_REALTIME_URL = _Env.CHAT_GRAPHQL_REALTIME_URL;
  @EnviedField()
  static const NOMINATIM_API_URL = _Env.NOMINATIM_API_URL;
}
