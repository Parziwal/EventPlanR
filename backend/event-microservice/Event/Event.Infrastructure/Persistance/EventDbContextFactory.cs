using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore;

namespace Event.Infrastructure.Persistance;

public class EventDbContextFactory : IDesignTimeDbContextFactory<EventDbContext>
{
    public EventDbContext CreateDbContext(string[] args)
    {
        var optionsBuilder = new DbContextOptionsBuilder<EventDbContext>();
        optionsBuilder.UseNpgsql(args[0], npsql => npsql.UseNetTopologySuite());

        return new EventDbContext(optionsBuilder.Options);
    }
}
