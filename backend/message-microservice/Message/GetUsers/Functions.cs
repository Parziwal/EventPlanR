using System.Net;
using Amazon.Lambda.Core;
using Amazon.Lambda.APIGatewayEvents;
using Amazon.CognitoIdentityProvider;
using Amazon.CognitoIdentityProvider.Model;
using System.Text.Json;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace GetUsers;

public class Functions
{
    private readonly IAmazonCognitoIdentityProvider _cognito;

    public Functions()
    {
        _cognito = new AmazonCognitoIdentityProviderClient();
    }

    public async Task<APIGatewayProxyResponse> Get(APIGatewayProxyRequest request, ILambdaContext context)
    {
        var listUsersRequest = new ListUsersRequest
        {
            UserPoolId = Environment.GetEnvironmentVariable("USER_POOL_ID"),
            AttributesToGet = new List<string> { "email", "name" },
        };
        var usersResponse = await _cognito.ListUsersAsync(listUsersRequest);

        var users = usersResponse.Users.Select(u => new {
            Email = u.Attributes.Where(a => a.Name == "email").SingleOrDefault()?.Value,
            Name = u.Attributes.Where(a => a.Name == "name").SingleOrDefault()?.Value
        });

        var response = new APIGatewayProxyResponse
        {
            StatusCode = (int)HttpStatusCode.OK,
            Body = JsonSerializer.Serialize(users),
            Headers = new Dictionary<string, string> { { "Content-Type", "application/json" } }
        };

        return response;
    }
}