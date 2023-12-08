using EventPlanr.Domain.Common;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Domain.Entities;

public class InvitationEntity : BaseAuditableEntity
{
    public Guid UserId { get; set; }
    public InvitationStatus Status { get; set; }
    public Guid EventId { get; set; }
    public EventEntity Event { get; set; } = null!;
}
