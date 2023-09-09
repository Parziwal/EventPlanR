using EventPlanr.Domain.Common;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Domain.Entities;

public class Event : BaseAuditableEntity
{
    public string Name { get; set; } = null!;
    public string? Description { get; set; }
    public string? CoverImageUrl { get; set; }
    public EventCategory Category { get; set; }
    public DateTimeOffset FromDate { get; set; }
    public DateTimeOffset ToDate { get; set; }
    public string Venue { get; set; } = null!;
    public Address Address { get; set; } = null!;
    public Coordinates Coordinates { get; set; } = null!;
    public Language Language { get; set; }
    public Currency Currency { get; set; }
    public bool IsPrivate { get; set; }
    public Guid OrganizationId { get; set; }
    public Organization Organization { get; set; } = null!;
    public List<NewsPost> NewsPosts { get; set; } = new List<NewsPost>();
    public List<Ticket> Tickets { get; set; } = new List<Ticket>();
}
