using EventPlanr.Domain.Common;

namespace EventPlanr.Domain.Entities;

public class NewsPostEntity : BaseAuditableEntity
{
    public string Text { get; set; } = null!;
    public Guid EventId { get; set; }
    public EventEntity Event { get; set; } = null!;
}
