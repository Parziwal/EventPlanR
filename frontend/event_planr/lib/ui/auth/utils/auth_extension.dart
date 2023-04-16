import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/ui/auth/auth.dart';

extension AuthX on AuthError {
  String getErrorMessage(AppLocalizations l10) {
    if (exception is CognitoClientException) {
      final cognitoException = exception as CognitoClientException;
      if (cognitoException.code == 'UserNotFoundException' ||
          cognitoException.code == 'NotAuthorizedException') {
        return l10.authExceptionWrongCredentials;
      } else if (cognitoException.code == 'UsernameExistsException') {
        return l10.authExceptionEmailExists;
      } else if (cognitoException.code == 'CodeMismatchException') {
        return l10.authExceptionCodeMismatch;
      }
    }

    return l10.authExceptionUnknown;
  }
}
