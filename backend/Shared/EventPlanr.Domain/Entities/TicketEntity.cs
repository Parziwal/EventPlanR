using EventPlanr.Domain.Common;

namespace EventPlanr.Domain.Entities;

public class TicketEntity : BaseSoftDeleteAuditableEntity
{
    public string Name { get; set; } = null!;
    public double Price { get; set; }
    public int Count { get; set; }
    public int RemainingCount { get; set; }
    public string? Description { get; set; }
    public DateTimeOffset SaleStarts { get; set; }
    public DateTimeOffset SaleEnds { get; set; }
    public Guid EventId { get; set; }
    public EventEntity Event { get; set; } = null!;
    public List<SoldTicketEntity> SoldTickets { get; set; } = new List<SoldTicketEntity>();
}
