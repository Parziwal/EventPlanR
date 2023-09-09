using EventPlanr.Domain.Common;

namespace EventPlanr.Domain.Entities;

public class NewsPost : BaseAuditableEntity
{
    public string Text { get; set; } = null!;
    public Guid EventId { get; set; }
    public Event Event { get; set; } = null!;
}
