namespace EventPlanr.Infrastructure.Options;

public class DynamoDbTableOptions
{
    public string UserClaimTable { get; set; } = null!;
    public string UserReservedTicketOrderTable { get; set; } = null!;
    public string ChatMessageTable { get; set; } = null!;
}
