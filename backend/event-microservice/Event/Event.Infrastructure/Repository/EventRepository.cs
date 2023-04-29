using Event.Application.Contracts;
using Event.Application.Dto;
using Event.Application.Extensions;
using Event.Infrastructure.Persistance;
using Microsoft.EntityFrameworkCore;
using NetTopologySuite.Geometries;
using Entities = Event.Domain.Entities;

namespace Event.Infrastructure.Repository;

public class EventRepository : IEventRepository
{
    private readonly EventDbContext _dbContext;

    public EventRepository(EventDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<List<Entities.Event>> GetEventsAsync(EventFilterDto filter)
    {
        return await _dbContext.Events
            .Where(filter.SearchTerm != null, e => 
                e.Name.Contains(filter.SearchTerm!)
                || (e.Description != null && e.Description.Contains(filter.SearchTerm!))
                || e.Address.Venue.Contains(filter.SearchTerm!))
            .Where(filter.Category != null, e => e.Category == filter.Category)
            .Where(filter.FromDate != null, e => e.FromDate >= filter.FromDate)
            .Where(filter.ToDate != null, e => e.ToDate <= filter.ToDate)
            .Where(filter.Location != null, e => e.Address.Location.Distance(
                    new Point(filter.Location!.Longitude, filter.Location!.Latitude)
                ) < filter.Location.Radius)
            .ToListAsync();
    }

    public async Task<Entities.Event> GetEventById(Guid id)
    {
        return await _dbContext.Events.SingleAsync(e => e.Id == id);
    }
}
