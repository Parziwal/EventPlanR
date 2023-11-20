import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_code_mismatch_exception.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_email_already_taken_exception.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_invalid_password_exception.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_sign_in_not_confirmed_with_new_password_exception.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_sign_up_not_confirmed_exception.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_wrong_credentials_exception.dart';
import 'package:event_planr_app/domain/exceptions/common/domain_exception.dart';
import 'package:event_planr_app/domain/exceptions/common/entity_not_found_exception.dart';
import 'package:event_planr_app/domain/exceptions/common/validation_exception.dart';
import 'package:event_planr_app/l10n/l10n.dart';

extension ErrorLocalizationsX on AppLocalizations {
  String translateError(Exception exception) {
    if (exception is AuthEmailAlreadyTakenException) {
      return auth_EmailAlreadyTakenException;
    } else if (exception is AuthCodeMismatchException) {
      return auth_CodeMismatchException;
    } else if (exception is AuthWrongCredentialsException) {
      return auth_WrongCredentialsException;
    } else if (exception is AuthSignUpNotConfirmedException) {
      return auth_SignUpNotConfirmedException;
    } else if (exception is AuthSignInNotConfirmedWithNewPasswordException) {
      return auth_SignInNotConfirmedWithNewPasswordException;
    } else if (exception is AuthInvalidPasswordException) {
      return auth_InvalidPasswordException;
    } else if (exception is ValidationException) {
      return validationException;
    } else if (exception is ForbiddenException) {
      return forbiddenException;
    } else if (exception is EntityNotFoundException) {
      return exception.title;
    } else if (exception is DomainException) {
      return exception.title;
    }

    return unknownException;
  }
}
