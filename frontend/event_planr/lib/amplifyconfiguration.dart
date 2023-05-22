import 'package:event_planr/env/env.dart';

const amplifyconfig = '''
  {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
      "plugins": {
        "awsAPIPlugin": {
          "event_planr_chat": {
            "endpointType": "GraphQL",
            "endpoint": "${Env.CHAT_GRAPHQL_URL}",
            "region": "us-east-1",
            "authorizationType": "API_KEY",
            "apiKey": "${Env.CHAT_GRAPHQL_API_KEY}"
          }
        }
      }
    }
  }
''';
