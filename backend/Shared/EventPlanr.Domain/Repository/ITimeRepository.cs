namespace EventPlanr.Domain.Repository;
public interface ITimeRepository
{
    DateTimeOffset GetCurrentUtcTime();
}
