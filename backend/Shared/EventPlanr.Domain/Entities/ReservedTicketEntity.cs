using EventPlanr.Domain.Enums;

namespace EventPlanr.Domain.Entities;

public class ReservedTicketEntity
{
    public Guid TicketId { get; set; }
    public int Count { get; set; }
    public double Price { get; set; }
    public Currency Currency { get; set; }
}
