using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.DocumentModel;
using Amazon.DynamoDBv2.Model;
using EventPlanr.Application.Contracts;
using EventPlanr.Domain.DocumentModels;
using EventPlanr.Infrastructure.Options;
using Microsoft.Extensions.Options;
using System.Text.Json;

namespace EventPlanr.Infrastructure.User;

public class UserService : IUserService
{
    private readonly IAmazonDynamoDB _dynamoDb;
    private readonly DynamoDbTableOptions _dynamoDbTableOptions;

    public UserService(IAmazonDynamoDB dynamoDb, IOptions<DynamoDbTableOptions> dynamoDbTableOptions)
    {
        _dynamoDb = dynamoDb;
        _dynamoDbTableOptions = dynamoDbTableOptions.Value;
    }

    public async Task AddOrganizationToUserClaimsAsync(Guid userId, Guid organizationId)
    {
        var addOrganizationRequest = new UpdateItemRequest
        {
            TableName = _dynamoDbTableOptions.UserOrganizationClaimTable,
            Key = new Dictionary<string, AttributeValue>()
            { 
                { "UserId", new AttributeValue { S = userId.ToString() } } 
            },
            ExpressionAttributeValues = new Dictionary<string, AttributeValue>()
            {
                {":org",new AttributeValue { S = organizationId.ToString() } },
            },
            UpdateExpression = "ADD OrganizationIds :org"
        };

        await _dynamoDb.UpdateItemAsync(addOrganizationRequest);
    }

    public async Task RemoveOrganizationFromUserClaimsAsync(Guid userId, Guid organizationId)
    {
        var removeOrganizationRequest = new UpdateItemRequest
        {
            TableName = _dynamoDbTableOptions.UserOrganizationClaimTable,
            Key = new Dictionary<string, AttributeValue>()
            {
                { "UserId", new AttributeValue { S = userId.ToString() } }
            },
            ExpressionAttributeValues = new Dictionary<string, AttributeValue>()
            {
                {":org",new AttributeValue { S = organizationId.ToString() } },
            },
            UpdateExpression = "DELETE OrganizationIds :org"
        };

        await _dynamoDb.UpdateItemAsync(removeOrganizationRequest);
    }

    public async Task<List<Guid>> GetUserOrganizationsAsync(Guid userId)
    {
        var getOrganizationsRequest = new GetItemRequest
        {
            TableName = _dynamoDbTableOptions.UserOrganizationClaimTable,
            Key = new Dictionary<string, AttributeValue>
            {
                 { "UserId", new AttributeValue { S = userId.ToString() } }
            }
        };

        var response = await _dynamoDb.GetItemAsync(getOrganizationsRequest);
        if (response.Item.Count == 0)
        {
            return new List<Guid>();
        }

        var itemAsDocument = Document.FromAttributeMap(response.Item);
        var claimDocumentModel = JsonSerializer.Deserialize<UserOrganizationClaimDocumentModel>(itemAsDocument.ToJson())!;

        return claimDocumentModel.OrganizationIds;
    }
}
