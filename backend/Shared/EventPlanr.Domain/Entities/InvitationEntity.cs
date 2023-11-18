using EventPlanr.Domain.Common;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Domain.Entities;

public class InvitationEntity : BaseAuditableEntity
{
    public string UserEmail { get; set; } = null!;
    public Guid? UserId { get; set; }
    public InvitationStatus Status { get; set; }
    public bool IsCheckedIn { get; set; }
    public Guid EventId { get; set; }
    public EventEntity Event { get; set; } = null!;
}
