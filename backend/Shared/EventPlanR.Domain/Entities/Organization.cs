using EventPlanr.Domain.Common;

namespace EventPlanr.Domain.Entities;

public class Organization : BaseAuditableEntity
{
    public string Name { get; set; } = null!;
    public string? Description { get; set; }
    public string? ProfileImageUrl { get; set; }
    public List<string> MemberUserIds { get; set; } = new List<string>();
    public List<Event> Events { get; set; } = new List<Event>();
}
