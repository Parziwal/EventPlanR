using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Extensions;
using EventPlanr.Domain.Repositories;
using EventPlanr.Domain.Repositories.Models;
using EventPlanr.Infrastructure.Extensions;
using EventPlanr.Infrastructure.Persistance;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Infrastructure.Repositories;

public class EventRepository : IEventRepository
{
    private readonly EventPlanrDbContext _context;

    public EventRepository(EventPlanrDbContext context)
    {
        _context = context;
    }

    public Task<Event> GetEventByIdAsync(Guid eventId)
        => _context.Events.SingleEntityAsync(e => e.Id == eventId, eventId);

    public Task<PaginatedList<Event>> GetEventsAsync(EventFilter filter, PageData page)
        => _context.Events
            .AsNoTracking()
            .Where(filter.SearchTerm != null, e =>
                e.Name.ToLower().Contains(filter.SearchTerm!.ToLower())
                || (e.Description != null && e.Description.ToLower().Contains(filter.SearchTerm!.ToLower()))
                || e.Venue.ToLower().Contains(filter.SearchTerm!.ToLower()))
            .Where(filter.Category != null, e => e.Category == filter.Category)
            .Where(filter.Language != null, e => e.Language == filter.Language)
            .Where(filter.Currency != null, e => e.Currency == filter.Currency)
            .Where(filter.FromDate != null, e => e.FromDate >= filter.FromDate)
            .Where(filter.ToDate != null, e => e.ToDate <= filter.ToDate)
            .Where(filter.Location != null, e => e.Coordinates.GetDistance(filter.Location!) < filter.Location!.Radius)
            .ToPaginatedListAsync(page);
}
