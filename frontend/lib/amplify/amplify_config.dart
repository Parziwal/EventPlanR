import 'package:event_planr_app/env/env.dart';

const amplifyConfig = '''
{
  "UserAgent": "aws-amplify-cli/2.0",
  "Version": "1.0",
  "auth": {
    "plugins": {
      "awsCognitoAuthPlugin": {
        "CognitoUserPool": {
          "Default": {
            "PoolId": "${Env.cognitoPoolId}",
            "AppClientId": "${Env.cognitoPoolClientId}",
            "Region": "${Env.awsRegion}"
          }
        },
        "Auth": {
          "Default": {
            "authenticationFlowType": "USER_SRP_AUTH"
          }
        }
      }
    }
  },
  "api": {
    "plugins": {
      "awsAPIPlugin": {
        "chat_message": {
          "endpointType": "GraphQL",
          "endpoint": "${Env.chatMessageGraphqlUrl}",
          "region": "us-east-1",
          "authorizationType": "AMAZON_COGNITO_USER_POOLS"
        }
      }
    }
  }
}
''';
