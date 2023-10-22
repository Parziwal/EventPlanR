using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.DocumentModel;
using Amazon.DynamoDBv2.Model;
using EventPlanr.Application.Contracts;
using EventPlanr.Domain.Entities;
using EventPlanr.Infrastructure.Options;
using Microsoft.Extensions.Options;
using System.Text.Json;

namespace EventPlanr.Infrastructure.Ticket;

public class TicketService : ITicketService
{
    private readonly IAmazonDynamoDB _dynamoDb;
    private readonly DynamoDbTableOptions _dynamoDbTableOptions;

    public TicketService(IAmazonDynamoDB dynamoDb, IOptions<DynamoDbTableOptions> dynamoDbTableOptions)
    {
        _dynamoDb = dynamoDb;
        _dynamoDbTableOptions = dynamoDbTableOptions.Value;
    }

    public async Task<List<ReservedTicketEntity>> GetUserReservedTicketsAsync(Guid userId)
    {
        var getReservedTicketsRequest = new GetItemRequest
        {
            TableName = _dynamoDbTableOptions.UserReservedTicketOrderTable,
            Key = new Dictionary<string, AttributeValue>
            {
                 { "UserId", new AttributeValue { S = userId.ToString() } }
            }
        };
        var reservedTicketsResponse = await _dynamoDb.GetItemAsync(getReservedTicketsRequest);

        if (reservedTicketsResponse.Item.Count == 0)
        {
            return new List<ReservedTicketEntity>();
        }

        var reservedTicketsAsDocument = Document.FromAttributeMap(reservedTicketsResponse.Item);
        var reservedTickets = JsonSerializer.Deserialize<UserReservedTicketOrderEntity>(reservedTicketsAsDocument)!;
        return reservedTickets.ReservedTickets;
    }

    public async Task<DateTimeOffset> ReserveTicketsAsync(Guid userId, List<ReservedTicketEntity> reserveTickets)
    {
        var resarvationTime = DateTimeOffset.UtcNow.AddMinutes(10);

        var reservedTickets = new UserReservedTicketOrderEntity()
        {
            UserId = userId,
            ExpirationTime = resarvationTime.UtcTicks,
            ReservedTickets = reserveTickets,
        };

        var reservedTicketsAsJson = JsonSerializer.Serialize(reservedTickets);
        var reservedTicketsAsDocument = Document.FromJson(reservedTicketsAsJson);
        var reservedTicketsAsAttributes = reservedTicketsAsDocument.ToAttributeMap();

        var putReservedTicketRequest = new PutItemRequest
        {
            TableName = _dynamoDbTableOptions.UserReservedTicketOrderTable,
            Item = reservedTicketsAsAttributes,
        };

        await _dynamoDb.PutItemAsync(putReservedTicketRequest);

        return resarvationTime;
    }
}
