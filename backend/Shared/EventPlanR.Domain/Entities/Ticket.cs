using EventPlanR.Domain.Common;

namespace EventPlanR.Domain.Entities;

public class Ticket : BaseAuditableEntity
{
    public string Name { get; set; } = null!;
    public double Price { get; set; }
    public string? Description { get; set; }
    public Guid EventId { get; set; }
    public Event Event { get; set; } = null!;
    public SoldTicket SoldTicket { get; set; } = null!;
}
