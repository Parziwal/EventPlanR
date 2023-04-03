namespace Event.Application.Dto;

public class EventDto
{
    public int Id { get; set; }
    public string Name { get; set; } = default!;
    public string Type { get; set; } = default!;
    public DateTimeOffset FromDate { get; set; } = default!;
    public string? CoverImageUrl { get; set; }
}
