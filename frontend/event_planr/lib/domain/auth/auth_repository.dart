import 'dart:developer';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:event_planr/data/disk/auth/auth_storage.dart';
import 'package:event_planr/domain/auth/auth.dart';
import 'package:event_planr/env/env.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthRepository {
  AuthRepository({required AuthStorage storage})
      : _userPool = CognitoUserPool(
          Env.COGNITO_USER_POOL_ID,
          Env.COGNITO_CLIENT_ID,
          storage: storage,
        );

  final CognitoUserPool _userPool;
  CognitoUser? _cognitoUser;

  Future<bool> get isAuthenticated async {
    try {
      final session = await _cognitoUser?.getSession();
      return session?.isValid() ?? false;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<String> get bearerToken async {
    final session = await _cognitoUser?.getSession();
    if (session?.isValid() ?? false) {
      return 'Bearer ${session!.idToken.jwtToken!}';
    }

    return '';
  }

  Future<User> get user async {
    final attributes = await _cognitoUser!.getUserAttributes();
    return User.fromJson(
      attributes!.fold(<String, String>{}, (a, b) => {b.name!: b.value, ...a}),
    );
  }

  Future<void> loginUser(LoginCredentials credentials) async {
    _cognitoUser = CognitoUser(
      credentials.email,
      _userPool,
      storage: _userPool.storage,
    );
    final authDetails = AuthenticationDetails(
      username: credentials.email,
      password: credentials.password,
    );

    try {
      await _cognitoUser!.authenticateUser(authDetails);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> signUpUser(SignUpCredentials credentials) async {
    _cognitoUser = CognitoUser(
      credentials.email,
      _userPool,
      storage: _userPool.storage,
    );
    final userAttributes = [
      AttributeArg(name: 'name', value: credentials.fullName),
    ];

    try {
      await _userPool.signUp(
        credentials.email,
        credentials.password,
        userAttributes: userAttributes,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<bool> autoLogin() async {
    _cognitoUser = await _userPool.getCurrentUser();
    if (_cognitoUser == null) {
      return false;
    }

    try {
      final session = await _cognitoUser!.getSession();
      return session?.isValid() ?? false;
    } catch (e) {
      log(e.toString());
    }

    return false;
  }

  Future<void> confirmRegistration(String code) async {
    try {
      await _cognitoUser!.confirmRegistration(code);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> resendConfirmationCode() async {
    try {
      await _cognitoUser!.resendConfirmationCode();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> forgotPassword(String email) async {
    _cognitoUser = CognitoUser(email, _userPool);

    try {
      await _cognitoUser!.forgotPassword();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> confirmPassword(ForgotPasswordCredentials credentials) async {
    try {
      await _cognitoUser!.confirmPassword(
        credentials.confirmCode,
        credentials.newPassword,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signOut() async {
    if (_cognitoUser != null) {
      return _cognitoUser!.signOut();
    }
  }
}
