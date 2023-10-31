using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.DocumentModel;
using Amazon.DynamoDBv2.Model;
using EventPlanr.Application.Contracts;
using EventPlanr.Domain.Entities;
using EventPlanr.Infrastructure.Options;
using Microsoft.Extensions.Options;
using System.Text.Json;

namespace EventPlanr.Infrastructure.Chat;

public class ChatService : IChatService
{
    private readonly IAmazonDynamoDB _dynamoDb;
    private readonly DynamoDbTableOptions _dynamoDbTableOptions;

    public ChatService(IAmazonDynamoDB dynamoDb, IOptions<DynamoDbTableOptions> dynamoDbTableOptions)
    {
        _dynamoDb = dynamoDb;
        _dynamoDbTableOptions = dynamoDbTableOptions.Value;
    }

    public async Task<List<ChatMessageEntity>> GetChatMessagesAsync(Guid chatId)
    {
        var queryMessagesRequest = new QueryRequest
        {
            TableName = _dynamoDbTableOptions.ChatMessageTable,
            KeyConditionExpression = "ChatId = :chatId",
            ExpressionAttributeValues = new Dictionary<string, AttributeValue> {
                {":chatId", new AttributeValue { S =  chatId.ToString() }}
            },
            ScanIndexForward = false,
        };
        var queryMessagesResponse = await _dynamoDb.QueryAsync(queryMessagesRequest);

        var messages = new List<ChatMessageEntity>();
        foreach (var item in queryMessagesResponse.Items)
        {
            var messageAsDocument = Document.FromAttributeMap(item);
            var message = JsonSerializer.Deserialize<ChatMessageEntity>(messageAsDocument.ToJson())!;
            messages.Add(message);
        }

        return messages;
    }

    public async Task AddMessageToChat(ChatMessageEntity message)
    {
        var messageAsJson = JsonSerializer.Serialize(message);
        var messageAsDocument = Document.FromJson(messageAsJson);
        var messageAsAttributes = messageAsDocument.ToAttributeMap();

        var putOrganizationRequest = new PutItemRequest
        {
            TableName = _dynamoDbTableOptions.ChatMessageTable,
            Item = messageAsAttributes,
        };

        await _dynamoDb.PutItemAsync(putOrganizationRequest);
    }
}
