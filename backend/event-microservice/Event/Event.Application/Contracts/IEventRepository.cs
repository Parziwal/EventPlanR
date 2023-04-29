using Event.Application.Dto;
using Entities = Event.Domain.Entities;

namespace Event.Application.Contracts;

public interface IEventRepository
{
    Task<List<Entities.Event>> GetEventsAsync(EventFilterDto filter);
    Task<Entities.Event> GetEventById(Guid id);
}
