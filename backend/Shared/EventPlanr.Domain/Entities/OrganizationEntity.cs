using EventPlanr.Domain.Common;

namespace EventPlanr.Domain.Entities;

public class OrganizationEntity : BaseSoftDeleteAuditableEntity
{
    public string Name { get; set; } = null!;
    public string? Description { get; set; }
    public string? ProfileImageUrl { get; set; }
    public List<Guid> MemberUserIds { get; set; } = new List<Guid>();
    public List<EventEntity> Events { get; set; } = new List<EventEntity>();
}
