using EventPlanr.Domain.Common;

namespace EventPlanr.Domain.Entities;

public class Ticket : BaseAuditableEntity
{
    public string Name { get; set; } = null!;
    public double Price { get; set; }
    public int Count { get; set; }
    public string? Description { get; set; }
    public DateTimeOffset SaleStarts { get; set; }
    public DateTimeOffset SalesEnds { get; set; }
    public Guid EventId { get; set; }
    public Event Event { get; set; } = null!;
    public List<SoldTicket> SoldTickets { get; set; } = new List<SoldTicket>();
}
