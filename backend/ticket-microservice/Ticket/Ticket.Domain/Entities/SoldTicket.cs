using Amazon.DynamoDBv2.DataModel;

namespace Ticket.Domain.Entities;

[DynamoDBTable("SoldTicket")]
public class SoldTicket
{
    [DynamoDBHashKey("eventId")]
    public string EventId { get; set; } = default!;

    [DynamoDBRangeKey("id")]
    public string Id { get; set; } = default!;

    [DynamoDBProperty("ticketName")]
    public string TicketName { get; set; } = default!;

    [DynamoDBProperty("quantity")]
    public int Quantity { get; set; }

    [DynamoDBProperty("userId")]
    public string UserId { get; set; } = default!;
}
