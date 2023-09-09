using EventPlanR.Domain.Entities;
using EventPlanR.Domain.Repositories.Models;

namespace EventPlanR.Domain.Repositories;

public interface IEventRepository
{
    Task<List<Event>> GetEventsAsync(EventFilter filter, CancellationToken? cancellationToken = null);
    Task<Event> GetEventByIdAsync(Guid eventId, CancellationToken? cancellationToken = null);
}
