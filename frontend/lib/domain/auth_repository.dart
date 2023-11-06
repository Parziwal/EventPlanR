import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_code_mismatch_exception.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_email_already_taken_exception.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_invalid_password_exception.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_sign_up_not_confirmed_exception.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_wrong_credentials_exception.dart';
import 'package:event_planr_app/domain/exceptions/common/unknown_exception.dart'
    as common;
import 'package:event_planr_app/domain/models/auth/change_password.dart';
import 'package:event_planr_app/domain/models/auth/edit_user.dart';
import 'package:event_planr_app/domain/models/auth/user.dart';
import 'package:event_planr_app/domain/models/auth/user_forgot_password_credential.dart';
import 'package:event_planr_app/domain/models/auth/user_sign_in_credential.dart';
import 'package:event_planr_app/domain/models/auth/user_sign_up_credential.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthRepository {
  String? _userEmail;

  Future<bool> get isUserSignedIn async {
    final session = await Amplify.Auth.fetchAuthSession();
    return session.isSignedIn;
  }

  Future<String> get bearerToken async {
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    final session = await cognitoPlugin.fetchAuthSession();
    final identityId = session.userPoolTokensResult.value.idToken.raw;

    if (session.isSignedIn) {
      return 'Bearer $identityId';
    }

    return '';
  }

  Future<User> get user async {
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    final session = await cognitoPlugin.fetchAuthSession();
    final claimsJson =
        session.userPoolTokensResult.value.idToken.claims.toJson();

    if (claimsJson['organization_policies'] != null) {
      claimsJson['organization_policies'] =
          jsonDecode(claimsJson['organization_policies']! as String);
    }

    return User.fromJson(claimsJson);
  }

  Future<void> refreshToken() async {
    await Amplify.Auth.fetchAuthSession(
      options: const FetchAuthSessionOptions(forceRefresh: true),
    );
  }

  Future<void> signInUser(UserSignInCredential credential) async {
    _userEmail = credential.email;
    try {
      final result = await Amplify.Auth.signIn(
        username: credential.email,
        password: credential.password,
      );

      if (result.nextStep.signInStep == AuthSignInStep.confirmSignUp) {
        throw AuthSignUpNotConfirmedException();
      }

      if (kDebugMode) {
        safePrint(await bearerToken);
      }
    } on NotAuthorizedServiceException {
      throw AuthWrongCredentialsException();
    } on UserNotFoundException {
      throw AuthWrongCredentialsException();
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.runtimeTypeName} ${e.message}');
      throw common.UnknownException();
    }
  }

  Future<void> signUpUser(UserSignUpCredential credential) async {
    _userEmail = credential.email;
    try {
      final userAttributes = {
        AuthUserAttributeKey.email: credential.email,
        AuthUserAttributeKey.givenName: credential.firstName,
        AuthUserAttributeKey.familyName: credential.lastName,
        AuthUserAttributeKey.picture: '',
      };

      await Amplify.Auth.signUp(
        username: credential.email,
        password: credential.password,
        options: SignUpOptions(
          userAttributes: userAttributes,
        ),
      );
    } on UsernameExistsException {
      throw AuthEmailAlreadyTakenException();
    } on AuthException catch (e) {
      safePrint('Error signing up user: ${e.message}');
      throw common.UnknownException();
    }
  }

  Future<void> confirmSignUp(String code) async {
    try {
      await Amplify.Auth.confirmSignUp(
        username: _userEmail!,
        confirmationCode: code,
      );
    } on CodeMismatchException {
      throw AuthCodeMismatchException();
    } on AuthException catch (e) {
      safePrint('Error confirming user: ${e.runtimeType}');
      throw common.UnknownException();
    }
  }

  Future<void> resendConfirmationCode() async {
    try {
      await Amplify.Auth.resendSignUpCode(username: _userEmail!);
    } on AuthException catch (e) {
      safePrint('Error resending code: ${e.message}');
      throw common.UnknownException();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await Amplify.Auth.resetPassword(
        username: email,
      );
    } on AuthException catch (e) {
      safePrint('Error resetting password: ${e.message}');
      throw common.UnknownException();
    }
  }

  Future<void> confirmForgotPassword(
    UserForgotPasswordCredential credential,
  ) async {
    try {
      await Amplify.Auth.confirmResetPassword(
        username: _userEmail!,
        newPassword: credential.newPassword,
        confirmationCode: credential.confirmCode,
      );
    } on CodeMismatchException {
      throw AuthCodeMismatchException();
    } on AuthException catch (e) {
      safePrint('Error resetting password: ${e.message}');
      throw common.UnknownException();
    }
  }

  Future<void> signOut() async {
    await Amplify.Auth.signOut();
    _userEmail = null;
  }

  Future<void> editUser(EditUser user) async {
    try {
      final attributes = [
        AuthUserAttribute(
          userAttributeKey: AuthUserAttributeKey.email,
          value: user.email,
        ),
        AuthUserAttribute(
          userAttributeKey: AuthUserAttributeKey.givenName,
          value: user.firstName,
        ),
        AuthUserAttribute(
          userAttributeKey: AuthUserAttributeKey.familyName,
          value: user.lastName,
        ),
      ];
      final result = await Amplify.Auth.updateUserAttributes(
        attributes: attributes,
      );
      await refreshToken();

      if (result.values.any(
        (e) =>
            e.nextStep.updateAttributeStep ==
            AuthUpdateAttributeStep.confirmAttributeWithCode,
      )) {
        throw AuthSignUpNotConfirmedException();
      }
    } on AuthException catch (e) {
      safePrint('Error updating user attribute: ${e.message}');
      throw common.UnknownException();
    }
  }

  Future<void> changePassword(ChangePassword password) async {
    try {
      await Amplify.Auth.updatePassword(
        oldPassword: password.oldPassword,
        newPassword: password.newPassword,
      );
    } on NotAuthorizedServiceException {
      throw AuthInvalidPasswordException();
    } on AuthException catch (e) {
      safePrint('Error updating password: ${e.message}');
      throw common.UnknownException();
    }
  }

  Future<void> verifyUserEmail(String confirmationCode) async {
    try {
      await Amplify.Auth.confirmUserAttribute(
        userAttributeKey: AuthUserAttributeKey.email,
        confirmationCode: confirmationCode,
      );
    } on CodeMismatchException {
      throw AuthCodeMismatchException();
    } on AuthException catch (e) {
      safePrint('Error confirming attribute update: ${e.message}');
      throw common.UnknownException();
    }
  }

  Future<void> resendEmailVerificationCode() async {
    try {
      await Amplify.Auth.resendUserAttributeConfirmationCode(
        userAttributeKey: AuthUserAttributeKey.email,
      );
    } on AuthException catch (e) {
      safePrint('Error resending code: ${e.message}');
      throw common.UnknownException();
    }
  }
}
