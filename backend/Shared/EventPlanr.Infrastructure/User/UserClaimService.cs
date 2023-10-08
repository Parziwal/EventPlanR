using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.DocumentModel;
using Amazon.DynamoDBv2.Model;
using EventPlanr.Application.Contracts;
using EventPlanr.Domain.Entities;
using EventPlanr.Infrastructure.Options;
using Microsoft.Extensions.Options;
using System.Text.Json;

namespace EventPlanr.Infrastructure.User;

public class UserClaimService : IUserClaimService
{
    private readonly IAmazonDynamoDB _dynamoDb;
    private readonly DynamoDbTableOptions _dynamoDbTableOptions;

    public UserClaimService(IAmazonDynamoDB dynamoDb, IOptions<DynamoDbTableOptions> dynamoDbTableOptions)
    {
        _dynamoDb = dynamoDb;
        _dynamoDbTableOptions = dynamoDbTableOptions.Value;
    }

    public async Task<UserClaimEntity> GetUserClaimAsync(Guid userId)
    {
        var getUserClaimsRequest = new GetItemRequest
        {
            TableName = _dynamoDbTableOptions.UserClaimTable,
            Key = new Dictionary<string, AttributeValue>
            {
                 { "UserId", new AttributeValue { S = userId.ToString() } }
            }
        };
        var userClaimResponse = await _dynamoDb.GetItemAsync(getUserClaimsRequest);

        if (userClaimResponse.Item.Count == 0)
        {
            return new UserClaimEntity()
            {
                UserId = userId,
            };
        }

        var userClaimAsDocument = Document.FromAttributeMap(userClaimResponse.Item);
        return JsonSerializer.Deserialize<UserClaimEntity>(userClaimAsDocument.ToJson())!;
    }

    public async Task PutOrganizationToUserAsync(Guid userId, OrganizationPolicyEntity organization)
    {
        var userClaim = await GetUserClaimAsync(userId);
        var existingOrganization = userClaim.Organizations
            .SingleOrDefault(o => o.OrganizationId == organization.OrganizationId);
        if (existingOrganization != null)
        {
            userClaim.Organizations.Remove(existingOrganization);
        }
        userClaim.Organizations.Add(organization);

        var claimAsJson = JsonSerializer.Serialize(userClaim);
        var claimAsDocument = Document.FromJson(claimAsJson);
        var claimAsAttributes = claimAsDocument.ToAttributeMap();

        var putOrganizationRequest = new PutItemRequest
        {
            TableName = _dynamoDbTableOptions.UserClaimTable,
            Item = claimAsAttributes,
        };

        await _dynamoDb.PutItemAsync(putOrganizationRequest);
    }

    public async Task RemoveOrganizationFromUserAsync(Guid userId, Guid organizationId)
    {
        var userClaim = await GetUserClaimAsync(userId);
        userClaim.Organizations = userClaim.Organizations
            .Where(o => o.OrganizationId != organizationId)
            .ToList();

        var claimAsJson = JsonSerializer.Serialize(userClaim);
        var claimAsDocument = Document.FromJson(claimAsJson);
        var claimAsAttributes = claimAsDocument.ToAttributeMap();

        var removeOrganizationRequest = new PutItemRequest
        {
            TableName = _dynamoDbTableOptions.UserClaimTable,
            Item = claimAsAttributes,
        };

        await _dynamoDb.PutItemAsync(removeOrganizationRequest);
    }

    public async Task SetUserCurrentOrganization(Guid userId, Guid organizationId)
    {
        var setCurrentOrganizationRequest = new UpdateItemRequest
        {
            TableName = _dynamoDbTableOptions.UserClaimTable,
            Key = new Dictionary<string, AttributeValue>()
            {
                { "UserId", new AttributeValue { S = userId.ToString() } }
            },
            ExpressionAttributeNames = new Dictionary<string, string>()
            {
                {"#current", "CurrentOrganizationId"},
            },
            ExpressionAttributeValues = new Dictionary<string, AttributeValue>()
            {
                {":new", new AttributeValue { S = organizationId.ToString() } },
            },
            UpdateExpression = "SET #current = :new"
        };

        await _dynamoDb.UpdateItemAsync(setCurrentOrganizationRequest);
    }
}
