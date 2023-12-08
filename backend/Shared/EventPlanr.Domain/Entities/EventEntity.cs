using EventPlanr.Domain.Common;
using EventPlanr.Domain.Enums;
using NetTopologySuite.Geometries;

namespace EventPlanr.Domain.Entities;

public class EventEntity : BaseSoftDeleteAuditableEntity
{
    public string Name { get; set; } = null!;
    public string? Description { get; set; }
    public string? CoverImageUrl { get; set; }
    public EventCategory Category { get; set; }
    public DateTimeOffset FromDate { get; set; }
    public DateTimeOffset ToDate { get; set; }
    public string Venue { get; set; } = null!;
    public Address Address { get; set; } = null!;
    public Point Coordinate { get; set; } = null!;
    public Currency Currency { get; set; }
    public bool IsPrivate { get; set; }
    public bool IsPublished { get; set; }
    public Guid OrganizationId { get; set; }
    public OrganizationEntity Organization { get; set; } = null!;
    public Guid ChatId { get; set; }
    public ChatEntity Chat { get; set; } = null!;
    public Guid InvitationTicketId { get; set; }
    public List<NewsPostEntity> NewsPosts { get; set; } = new List<NewsPostEntity>();
    public List<TicketEntity> Tickets { get; set; } = new List<TicketEntity>();
    public List<InvitationEntity> Invitations { get; set; } = new List<InvitationEntity>();
}
