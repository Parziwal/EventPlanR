using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore;

namespace EventPlanR.Infrastructure.Persistance;

public class EventDbContextFactory : IDesignTimeDbContextFactory<EventPlanrDbContext>
{
    public EventPlanrDbContext CreateDbContext(string[] args)
    {
        var optionsBuilder = new DbContextOptionsBuilder<EventPlanrDbContext>();
        optionsBuilder.UseNpgsql(args[0]);

        return new EventPlanrDbContext(optionsBuilder.Options);
    }
}
