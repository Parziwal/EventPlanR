using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Infrastructure.Persistance;

public class EventPlanrDbContext : DbContext
{
    public EventPlanrDbContext() { }
    public EventPlanrDbContext(DbContextOptions options) : base(options) { }

    public DbSet<Event> Events => Set<Event>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(EventPlanrDbContext).Assembly);
    }
}
