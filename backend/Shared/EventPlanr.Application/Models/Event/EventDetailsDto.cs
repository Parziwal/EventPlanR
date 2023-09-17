using AutoMapper;
using EventPlanr.Application.Models.Common;
using EventPlanr.Domain.Enums;
using EventPlanr.Application.Models.Organization;
using EventPlanr.Application.Models.NewsPost;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.Event;

public class EventDetailsDto
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
    public CoordinatesDto Coordinates { get; set; } = null!;
    public OrganizationDto Organization { get; set; } = null!;
    public NewsPostDto? LatestNews { get; set; } = null!;

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<EventEntity, EventDetailsDto>()
                .ForMember(dest => dest.LatestNews, opt => opt.MapFrom(src => src.NewsPosts.FirstOrDefault()));
        }
    }
}
