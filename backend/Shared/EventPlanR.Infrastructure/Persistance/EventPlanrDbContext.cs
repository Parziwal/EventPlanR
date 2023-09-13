using EventPlanr.Application.Contracts;
using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Infrastructure.Persistance;

public class EventPlanrDbContext : DbContext, IApplicationDbContext
{
    public EventPlanrDbContext() { }
    public EventPlanrDbContext(DbContextOptions options) : base(options) { }

    public DbSet<Event> Events => Set<Event>();
    public DbSet<Organization> Organizations => Set<Organization>();
    public DbSet<NewsPost> NewsPosts => Set<NewsPost>();
    public DbSet<Ticket> Tickets => Set<Ticket>();
    public DbSet<SoldTicket> SoldTickets => Set<SoldTicket>();
    public DbSet<Order> Orders => Set<Order>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(EventPlanrDbContext).Assembly);
    }
}
