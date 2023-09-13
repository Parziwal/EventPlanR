using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Contracts;

public interface IApplicationDbContext
{
    DbSet<Event> Events { get; }
    DbSet<Organization> Organizations { get; }
    DbSet<NewsPost> NewsPosts { get; }
    DbSet<Ticket> Tickets { get; }
    DbSet<SoldTicket> SoldTickets { get; }
    DbSet<Order> Orders { get; }

    Task<int> SaveChangesAsync(CancellationToken cancellationToken);
}
