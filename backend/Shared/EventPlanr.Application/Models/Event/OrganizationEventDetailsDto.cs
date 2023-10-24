using AutoMapper;
using EventPlanr.Application.Models.Common;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Application.Models.Event;

public class OrganizationEventDetailsDto : BaseAuditableDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = null!;
    public string? Description { get; set; }
    public string? CoverImageUrl { get; set; }
    public EventCategory Category { get; set; }
    public DateTimeOffset FromDate { get; set; }
    public DateTimeOffset ToDate { get; set; }
    public string Venue { get; set; } = null!;
    public AddressDto Address { get; set; } = null!;
    public CoordinateDto Coordinate { get; set; } = null!;
    public Currency Currency { get; set; }
    public bool IsPrivate { get; set; }
    public bool IsPublished { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<EventEntity, OrganizationEventDetailsDto>();
        }
    }
}
