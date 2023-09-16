using AutoMapper;
using EventPlanr.Domain.Enums;
using Entities = EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.Event;

public class EventDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = null!;
    public EventCategory Category { get; set; }
    public DateTimeOffset FromDate { get; set; }
    public string Venue { get; set; } = null!;
    public string? CoverImageUrl { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<Entities.Event, EventDto>();
        }
    }
}
