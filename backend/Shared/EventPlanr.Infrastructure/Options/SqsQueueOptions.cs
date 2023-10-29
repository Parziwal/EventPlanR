namespace EventPlanr.Infrastructure.Options;

public class SqsQueueOptions
{
    public string ReservedTicketOrderExpirationQueueName { get; set; } = null!;
}
