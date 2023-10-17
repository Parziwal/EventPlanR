using AutoMapper;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Application.Models.Event;

public class EventDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = null!;
    public DateTimeOffset FromDate { get; set; }
    public DateTimeOffset ToDate { get; set; }
    public string Venue { get; set; } = null!;
    public string? CoverImageUrl { get; set; }
    public string OrganizationName { get; set; } = null!;

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<EventEntity, EventDto>()
                .ForMember(dest => dest.OrganizationName, opt => opt.MapFrom(src => src.Organization.Name));
        }
    }
}
