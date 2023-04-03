namespace Event.Domain.Entities;

public class Event
{
    public int Id { get; set; }
    public string Name { get; set; } = default!;
    public string Type { get; set; } = default!;
    public DateTimeOffset FromDate { get; set; } = default!;
    public DateTimeOffset ToDate { get; set; } = default!;
    public string Location { get; set; } = default!;
    public string? Description { get; set; }
    public string? CoverImageUrl { get; set; }
    public bool IsPrivate { get; set; }
}
