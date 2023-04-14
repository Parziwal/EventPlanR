import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:event_planr/data/disk/auth/storage.dart';
import 'package:event_planr/domain/auth/models/user_login_credentials.dart';
import 'package:event_planr/domain/auth/models/user_signup_credentials.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthRepository {
  AuthRepository({required Storage storage})
      : _userPool = CognitoUserPool(
          'us-east-1_nnnnnnnn',
          'nnnnnnnnnnnnnnnnnn',
          storage: storage,
        );

  final CognitoUserPool _userPool;
  CognitoUser? _cognitoUser;
  CognitoUserSession? _session;

  Future<void> loginUser(UserLoginCredentials user) async {
    _cognitoUser = CognitoUser(
      user.email,
      _userPool,
      storage: _userPool.storage,
    );
    final authDetails = AuthenticationDetails(
      username: user.email,
      password: user.password,
    );

    _session = await _cognitoUser!.authenticateUser(authDetails);
  }

  Future<void> signUpUser(UserSignUpCredentials user) async {
    final userAttributes = [
      AttributeArg(name: 'name', value: user.fullName),
    ];
    await _userPool.signUp(
      user.email,
      user.password,
      userAttributes: userAttributes,
    );
  }

  Future<bool> autoLogin() async {
    _cognitoUser = await _userPool.getCurrentUser();
    if (_cognitoUser == null) {
      return false;
    }
    _session = await _cognitoUser!.getSession();
    return _session?.isValid() ?? false;
  }

  Future<void> confirmUser(String confirmationCode) async {
    _cognitoUser = CognitoUser('', _userPool, storage: _userPool.storage);
    await _cognitoUser?.confirmRegistration('123456');
  }

  Future<void> resendConfirmationCode(String email) async {
    _cognitoUser = CognitoUser(email, _userPool, storage: _userPool.storage);
    await _cognitoUser?.resendConfirmationCode();
  }

  Future<void> signOut() async {
    if (_cognitoUser != null) {
      return _cognitoUser!.signOut();
    }
  }
}
