import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_code_mismatch_exception.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_email_already_taken_exception.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_sign_up_not_confirmed_exception.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_wrong_credentials_exception.dart';
import 'package:event_planr_app/domain/exceptions/common/unknown_exception.dart' as common;
import 'package:event_planr_app/domain/models/auth/user.dart';
import 'package:event_planr_app/domain/models/auth/user_forgot_password_credential.dart';
import 'package:event_planr_app/domain/models/auth/user_sign_in_credential.dart';
import 'package:event_planr_app/domain/models/auth/user_sign_up_credential.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthRepository {
  String? _userEmail;

  Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    return result.isSignedIn;
  }

  Future<String> get bearerToken async {
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    final result = await cognitoPlugin.fetchAuthSession();
    final identityId = result.identityIdResult.value;
    if (result.isSignedIn) {
      return 'Bearer $identityId';
    }

    return '';
  }

  Future<User> get user async {
    final userAttributes = await Amplify.Auth.fetchUserAttributes();
    return User.fromJson({
      for (final element in userAttributes)
        '${element.userAttributeKey}': element.value,
    });
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
      safePrint('Error confirming user: ${e.message}');
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
}
