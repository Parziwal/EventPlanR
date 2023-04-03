using Entities = Event.Domain.Entities;

namespace Event.Application.Contracts;

public interface IEventRepository
{
    Task<List<Entities.Event>> GetAllEventsAsync();
    Task<Entities.Event> GetEventById(int id);
}
