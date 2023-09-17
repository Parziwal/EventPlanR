using EventPlanr.Domain.Common;

namespace EventPlanr.Domain.Entities;

public class OrganizationEntity : BaseAuditableEntity
{
    public string Name { get; set; } = null!;
    public string? Description { get; set; }
    public string? ProfileImageUrl { get; set; }
    public List<string> MemberUserIds { get; set; } = new List<string>();
    public List<EventEntity> Events { get; set; } = new List<EventEntity>();
}
