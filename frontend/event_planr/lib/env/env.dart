import 'package:envied/envied.dart';

part 'env.g.dart';
// ignore_for_file: constant_identifier_names

@Envied(path: '.env')
abstract class Env {
  @EnviedField()
  static const EVENT_PLANR_API_URL = _Env.EVENT_PLANR_API_URL;
  @EnviedField()
  static const COGNITO_USER_POOL_ID = _Env.COGNITO_USER_POOL_ID;
  @EnviedField()
  static const COGNITO_CLIENT_ID = _Env.COGNITO_CLIENT_ID;
  @EnviedField()
  static const CHAT_GRAPHQL_URL = _Env.CHAT_GRAPHQL_URL;
  @EnviedField()
  static const CHAT_GRAPHQL_API_KEY = _Env.CHAT_GRAPHQL_API_KEY;
  @EnviedField()
  static const NOMINATIM_API_URL = _Env.NOMINATIM_API_URL;
}
