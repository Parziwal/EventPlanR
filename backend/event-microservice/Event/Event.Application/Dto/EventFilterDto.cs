using Event.Domain.Entities;

namespace Event.Application.Dto;

public class EventFilterDto
{
    public string? SearchTerm { get; set; }
    public EventCategory? Category { get; set; }
    public DateTimeOffset? FromDate { get; set; }
    public DateTimeOffset? ToDate { get; set; }
    public LocationFilterDto? Location { get; set; }
}
