using EventPlanr.Domain.Common;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Domain.Repositories.Models;

public class EventFilter
{
    public string? SearchTerm { get; set; }
    public EventCategory? Category { get; set; }
    public Language? Language { get; set; }
    public Currency? Currency { get; set; }
    public DateTimeOffset? FromDate { get; set; }
    public DateTimeOffset? ToDate { get; set; }
    public LocationFilter? Location { get; set; } = null!;
}
