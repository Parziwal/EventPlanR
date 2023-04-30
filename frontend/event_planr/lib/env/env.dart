import 'package:envied/envied.dart';
import 'package:flutter/foundation.dart';

part 'env.g.dart';
// ignore_for_file: constant_identifier_names

@Envied(path: '.env')
abstract class Env {
  @EnviedField()
  static const COGNITO_USER_POOL_ID = _Env.COGNITO_USER_POOL_ID;
  @EnviedField()
  static const COGNITO_CLIENT_ID = _Env.COGNITO_CLIENT_ID;
}
