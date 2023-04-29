using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore;

namespace Event.Infrastructure.Persistance;

public class EventDbContextFactory : IDesignTimeDbContextFactory<EventDbContext>
{
    public EventDbContext CreateDbContext(string[] args)
    {
        var optionsBuilder = new DbContextOptionsBuilder<EventDbContext>();
        optionsBuilder.UseNpgsql("Host=localhost;Port=5432;Username=event_dev;Password=event_dev;Database=event_dev",
            npsql => npsql.UseNetTopologySuite());

        return new EventDbContext(optionsBuilder.Options);
    }
}
