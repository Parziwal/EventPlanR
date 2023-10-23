using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Infrastructure.Persistance;
public class EventPlanrContextFactory : IDesignTimeDbContextFactory<EventPlanrDbContext>
{
    public EventPlanrDbContext CreateDbContext(string[] args)
    {
        var optionsBuilder = new DbContextOptionsBuilder<EventPlanrDbContext>();
        optionsBuilder.UseNpgsql(args.Length > 0 ? args[0] : "");
        
        return new EventPlanrDbContext(optionsBuilder.Options);
    }
}
