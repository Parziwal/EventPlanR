using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Repositories.Models;

namespace EventPlanr.Domain.Repositories;

public interface IEventRepository
{
    Task<List<Event>> GetEventsAsync(EventFilter filter, CancellationToken? cancellationToken = null);
    Task<Event> GetEventByIdAsync(Guid eventId, CancellationToken? cancellationToken = null);
}
