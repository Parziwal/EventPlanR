namespace EventPlanr.Domain.Entities;

public class UserReservedTicketOrderEntity
{
    public Guid UserId { get; set; }
    public long ExpirationTime { get; set; }
    public List<ReservedTicketEntity> ReservedTickets { get; set; } = new List<ReservedTicketEntity>();
}
