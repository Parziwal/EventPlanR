namespace Event.Domain.Entities;

public class Event
{
    public Guid Id { get; set; }
    public string Name { get; set; } = null!;
    public EventCategory Category { get; set; }
    public DateTimeOffset FromDate { get; set; }
    public DateTimeOffset ToDate { get; set; }
    public EventAddress Address { get; set; } = null!;
    public string? Description { get; set; }
    public string? CoverImageUrl { get; set; }
    public bool IsPrivate { get; set; }
}
