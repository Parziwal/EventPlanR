import 'package:event_planr_app/l10n/l10n.dart';

extension ErrorLocalizationsX on AppLocalizations {
  String translateError(String errorCode) {
    return switch (errorCode) {
      'AuthEmailAlreadyTakenException' => auth_EmailAlreadyTakenException,
      'AuthCodeMismatchException' => auth_CodeMismatchException,
      'AuthWrongCredentialsException' => auth_WrongCredentialsException,
      'AuthSignUpNotConfirmedException' => auth_SignUpNotConfirmedException,
      'AuthInvalidPasswordException' => auth_InvalidPasswordException,
      _ => unknownException,
    };
  }
}
