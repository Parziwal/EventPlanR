using Amazon.DynamoDBv2.DataModel;

namespace Ticket.Domain.Entities;

[DynamoDBTable("EventTicket")]
public class EventTicket
{
    [DynamoDBHashKey("eventId")]
    public string EventId { get; set; } = default!;

    [DynamoDBRangeKey("name")]
    public string Name { get; set; } = default!;

    [DynamoDBProperty("price")]
    public double Price { get; set; } = default!;

    [DynamoDBProperty("description")]
    public string Description { get; set; } = default!;
}