using EventPlanR.Domain.Entities;
using EventPlanR.Domain.Repositories;
using EventPlanR.Domain.Repositories.Models;

namespace EventPlanR.Infrastructure.Repositories;

public class EventRepository : IEventRepository
{
    public Task<Event> GetEventByIdAsync(Guid eventId, CancellationToken? cancellationToken = null)
    {
        throw new NotImplementedException();
    }

    public Task<List<Event>> GetEventsAsync(EventFilter filter, CancellationToken? cancellationToken = null)
    {
        throw new NotImplementedException();
    }
}
