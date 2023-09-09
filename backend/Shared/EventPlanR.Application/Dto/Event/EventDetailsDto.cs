using EventPlanr.Application.Dto.Common;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Application.Dto.Event;

public class EventDetailsDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = null!;
    public EventCategory Category { get; set; }
    public DateTimeOffset FromDate { get; set; }
    public DateTimeOffset ToDate { get; set; }
    public string Venue { get; set; } = null!;
    public AddressDto Address { get; set; } = null!;
    public CoordinatesDto Coordinates { get; set; } = null!;
    public string? Description { get; set; }
    public string? CoverImageUrl { get; set; }
}
