using EventPlanr.Domain.Common;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Domain.Entities;

public class Invitation : BaseAuditableEntity
{
    public string UserEmail { get; set; } = null!;
    public string? UserId { get; set; }
    public InvitationStatus Status { get; set; }
    public Guid EventId { get; set; }
    public Event Event { get; set; } = null!;
}
