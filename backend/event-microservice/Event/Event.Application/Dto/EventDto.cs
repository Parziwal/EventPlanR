﻿using Event.Domain.Entities;

namespace Event.Application.Dto;

public class EventDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = null!;
    public EventCategory Category { get; set; }
    public DateTimeOffset FromDate { get; set; }
    public string Venue { get; set; } = null!;
    public string? CoverImageUrl { get; set; }
}
