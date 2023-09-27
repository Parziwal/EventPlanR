abstract class Env {
  static late final String environment;
  static final String appName =
      environment == 'dev' ? '[DEV] Event Planr' : 'Event Planr';

  static const awsRegion = String.fromEnvironment('AWS_REGION');
  static const eventPlanrApiUrl = String.fromEnvironment('EVENT_PLANR_API_URL');
  static const cognitoPoolId = String.fromEnvironment('COGNITO_POOL_ID');
  static const cognitoPoolClientId =
      String.fromEnvironment('COGNITO_POOL_CLIENT_ID');
  static const chatGraphqlUrl = String.fromEnvironment('CHAT_GRAPHQL_URL');
  static const nominatimApiUrl = String.fromEnvironment('NOMINATIM_API_URL');
}
