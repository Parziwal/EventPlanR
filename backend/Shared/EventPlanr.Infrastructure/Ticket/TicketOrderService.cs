using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.DocumentModel;
using Amazon.DynamoDBv2.Model;
using Amazon.SQS;
using Amazon.SQS.Model;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Domain.Entities;
using EventPlanr.Infrastructure.Options;
using Microsoft.Extensions.Options;
using System.Text.Json;

namespace EventPlanr.Infrastructure.Ticket;

public class TicketOrderService : ITicketOrderService
{
    private readonly IAmazonDynamoDB _dynamoDb;
    private readonly IAmazonSQS _sqs;
    private readonly IApplicationDbContext _dbContext;
    private readonly DynamoDbTableOptions _dynamoDbTableOptions;
    private readonly SqsQueueOptions _sqsQueueOptions;

    public TicketOrderService(
        IAmazonDynamoDB dynamoDb,
        IAmazonSQS sqs,
        IApplicationDbContext dbContext,
        IOptions<DynamoDbTableOptions> dynamoDbTableOptions,
        IOptions<SqsQueueOptions> sqsQueueOptions)
    {
        _dynamoDb = dynamoDb;
        _sqs = sqs;
        _dbContext = dbContext;
        _dynamoDbTableOptions = dynamoDbTableOptions.Value;
        _sqsQueueOptions = sqsQueueOptions.Value;
    }

    public async Task<List<ReservedTicketEntity>> GetUserReservedTicketsAsync(Guid userId, bool onlyIfExpired = false)
    {
        var deleteReservedTicketsRequest = new DeleteItemRequest
        {
            TableName = _dynamoDbTableOptions.UserReservedTicketOrderTable,
            Key = new Dictionary<string, AttributeValue>
            {
                { "UserId", new AttributeValue { S = userId.ToString() } }
            },
            ReturnValues = "ALL_OLD",
            ExpressionAttributeValues = onlyIfExpired ? new Dictionary<string, AttributeValue>()
            {
                {":currentTime", new AttributeValue { N = DateTimeOffset.UtcNow.ToUnixTimeSeconds().ToString()}}
            } : null,
            ConditionExpression = onlyIfExpired ? "ExpirationTime < :currentTime" : null,
            ReturnValuesOnConditionCheckFailure = "ALL_OLD",
        };

        DeleteItemResponse? reservedTicketsResponse;

        try
        {
            reservedTicketsResponse = await _dynamoDb.DeleteItemAsync(deleteReservedTicketsRequest);
        }
        catch (ConditionalCheckFailedException)
        {
            return new List<ReservedTicketEntity>();
        }


        if (reservedTicketsResponse.Attributes.Count == 0)
        {
            return new List<ReservedTicketEntity>();
        }

        var reservedTicketsAsDocument = Document.FromAttributeMap(reservedTicketsResponse.Attributes);
        var reservedTickets = JsonSerializer.Deserialize<UserReservedTicketOrderEntity>(reservedTicketsAsDocument.ToJson())!;
        return reservedTickets.ReservedTickets;
    }

    public async Task<DateTimeOffset> ReserveTicketsAsync(Guid userId, List<ReservedTicketEntity> reserveTickets)
    {
        await ResetReservedTicketsForUserAsync(userId);
        
        var expirationTime = DateTimeOffset.UtcNow.AddMinutes(10);
        var reservedTicketOrder = new UserReservedTicketOrderEntity()
        {
            UserId = userId,
            ExpirationTime = expirationTime.ToUnixTimeSeconds(),
            ReservedTickets = reserveTickets,
        };

        var reservedTicketsAsJson = JsonSerializer.Serialize(reservedTicketOrder);
        var reservedTicketsAsDocument = Document.FromJson(reservedTicketsAsJson);
        var reservedTicketsAsAttributes = reservedTicketsAsDocument.ToAttributeMap();

        var putReservedTicketRequest = new PutItemRequest
        {
            TableName = _dynamoDbTableOptions.UserReservedTicketOrderTable,
            Item = reservedTicketsAsAttributes,
        };

        await _dynamoDb.PutItemAsync(putReservedTicketRequest);
        await SetExpiredReservedTicketsDeletionAsync(userId);

        return expirationTime;
    }

    public async Task RemoveUserExpiredTicketAsnyc(Guid userId)
    {
        await ResetReservedTicketsForUserAsync(userId, onlyIfExpired: true);
    }

    private async Task ResetReservedTicketsForUserAsync(Guid userId, bool onlyIfExpired = false)
    {
        var reservedTickets = await GetUserReservedTicketsAsync(userId, onlyIfExpired);
        if (reservedTickets.Count == 0)
        {
            return;
        }

        foreach (var reservedTicket in reservedTickets)
        {
            var ticket = await _dbContext.Tickets
                .SingleEntityAsync(t => t.Id == reservedTicket.TicketId);

            var remainingTicketCount = ticket.RemainingCount + reservedTicket.Count;
            ticket.RemainingCount = remainingTicketCount > ticket.Count ? ticket.Count : remainingTicketCount;
        }

        await _dbContext.SaveChangesAsync();
    }

    private async Task SetExpiredReservedTicketsDeletionAsync(Guid userId)
    {
        var queueUrl = await _sqs.GetQueueUrlAsync(_sqsQueueOptions.ReservedTicketOrderExpirationQueueName);
        var sqsRequest = new SendMessageRequest
        {
            QueueUrl = queueUrl.QueueUrl,
            MessageBody = userId.ToString(),
            DelaySeconds = 605,
        };

        await _sqs.SendMessageAsync(sqsRequest);
    }
}
