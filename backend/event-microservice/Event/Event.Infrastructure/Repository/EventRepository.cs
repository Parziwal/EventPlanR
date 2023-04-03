using Event.Application.Contracts;
using Event.Infrastructure.Persistance;
using Microsoft.EntityFrameworkCore;

namespace Event.Infrastructure.Repository;

public class EventRepository : IEventRepository
{
    private readonly EventDbContext _dbContext;

    public EventRepository(EventDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<List<Domain.Entities.Event>> GetAllEventsAsync()
    {
        return await _dbContext.Events.ToListAsync();
    }

    public async Task<Domain.Entities.Event> GetEventById(int id)
    {
        return await _dbContext.Events.SingleAsync(e => e.Id == id);
    }
}
