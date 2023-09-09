using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Repositories;
using EventPlanr.Domain.Repositories.Models;

namespace EventPlanr.Infrastructure.Repositories;

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
