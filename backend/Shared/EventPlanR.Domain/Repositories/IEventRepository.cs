using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Repositories.Models;

namespace EventPlanr.Domain.Repositories;

public interface IEventRepository
{
    Task<Event> GetEventByIdAsync(Guid eventId);
    Task<PaginatedList<Event>> GetEventsAsync(EventFilter filter, PageData page);
}
