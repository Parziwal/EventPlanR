import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:event_planr_app/amplify/amplify_config.dart';

Future<void> configureAmplify() async {
  try {
    await Amplify.addPlugins([AmplifyAuthCognito(), AmplifyAPI()]);
    await Amplify.configure(amplifyConfig);
  } on Exception catch (e) {
    safePrint('An error occurred configuring Amplify: $e');
  }
}
