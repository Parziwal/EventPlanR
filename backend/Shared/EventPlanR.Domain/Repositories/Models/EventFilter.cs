using EventPlanR.Domain.Common;
using EventPlanR.Domain.Enums;

namespace EventPlanR.Domain.Repositories.Models;

public class EventFilter
{
    public string? SearchTerm { get; set; }
    public EventCategory? Category { get; set; }
    public DateTimeOffset? FromDate { get; set; }
    public DateTimeOffset? ToDate { get; set; }
    public Coordinates? Coordinates { get; set; } = null!;
}
