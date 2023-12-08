namespace EventPlanr.Domain.Repository;

public class TimeRepository : ITimeRepository
{
    public DateTimeOffset GetCurrentUtcTime()
    {
        return DateTimeOffset.UtcNow;
    }
}
