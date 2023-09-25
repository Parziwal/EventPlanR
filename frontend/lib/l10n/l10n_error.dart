import 'package:event_planr_app/l10n/l10n.dart';

extension ErrorLocalizationsX on AppLocalizations {
  String translateError(String errorCode) {
    if (errorCode == 'AuthEmailAlreadyTakenException') {
      return authEmailAlreadyTakenException;
    } else if (errorCode == 'AuthCodeMismatchException') {
      return authCodeMismatchException;
    } else if (errorCode == 'AuthWrongCredentialsException') {
      return authWrongCredentialsException;
    } else if (errorCode == 'AuthSignUpNotConfirmedException') {
      return authSignUpNotConfirmedException;
    }

    return unknownException;
  }
}
