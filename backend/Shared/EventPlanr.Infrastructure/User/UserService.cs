using Amazon.CognitoIdentityProvider;
using Amazon.CognitoIdentityProvider.Model;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions.Common;
using EventPlanr.Domain.Entities;
using EventPlanr.Infrastructure.Options;
using Microsoft.Extensions.Options;

namespace EventPlanr.Infrastructure.User;

public class UserService : IUserService
{
    private readonly IAmazonCognitoIdentityProvider _cognitoClient;
    private readonly CognitoUserPoolOptions _cognitoUserPoolOptions;

    public UserService(
        IAmazonCognitoIdentityProvider cognitoClient,
        IOptions<CognitoUserPoolOptions> cognitoUserPoolOptions)
    {
        _cognitoClient = cognitoClient;
        _cognitoUserPoolOptions = cognitoUserPoolOptions.Value;
    }

    public async Task<Guid?> GetUserIdByEmail(string email)
    {
        var getUserWithEmailRequest = new ListUsersRequest
        {
            
            UserPoolId = _cognitoUserPoolOptions.UserPoolId,
            AttributesToGet = new List<string> { "sub" },
            Filter = $"\"email\"=\"{email}\"",
            Limit = 1,
        };
        var userResponse = await _cognitoClient.ListUsersAsync(getUserWithEmailRequest);

        if (userResponse.Users.Count == 0)
        {
            return null;
        }

        return new Guid(userResponse.Users.First().Attributes.First().Value);
    }

    public async Task<UserEntity> GetUserById(Guid userId)
    {
        var getUserWithEmailRequest = new ListUsersRequest
        {

            UserPoolId = _cognitoUserPoolOptions.UserPoolId,
            AttributesToGet = new List<string> { "sub", "email", "given_name", "family_name" },
            Filter = $"\"sub\"=\"{userId}\"",
            Limit = 1,
        };
        var userResponse = await _cognitoClient.ListUsersAsync(getUserWithEmailRequest);
        
        if (userResponse.Users.Count == 0)
        {
            throw new EntityNotFoundException("UserEntity");
        }

        var user = userResponse.Users.First();

        return new UserEntity() {
            Id = new Guid(user.Attributes.Single(a => a.Name == "sub").Value),
            FirstName = user.Attributes.Single(a => a.Name == "given_name").Value,
            LastName = user.Attributes.Single(a => a.Name == "family_name").Value,
            Email = user.Attributes.Single(a => a.Name == "email").Value,
        };
    }
}
