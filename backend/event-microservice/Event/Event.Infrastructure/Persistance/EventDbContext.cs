using Microsoft.EntityFrameworkCore;
using Entities = Event.Domain.Entities;

namespace Event.Infrastructure.Persistance;

public class EventDbContext : DbContext
{
    public EventDbContext() { }
    public EventDbContext(DbContextOptions options) : base(options) { }
    
    public DbSet<Entities.Event> Events => Set<Entities.Event>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        SnakeCaseIdentityTableNames(modelBuilder);
    }

    private static void SnakeCaseIdentityTableNames(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Entities.Event>(e => e.ToTable("events"));
    }
}
