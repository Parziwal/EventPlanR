using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Infrastructure.Persistance;
public class EventPlanrContextFactory : IDesignTimeDbContextFactory<EventPlanrDbContext>
{
    public EventPlanrDbContext CreateDbContext(string[] args)
    {
        var optionsBuilder = new DbContextOptionsBuilder<EventPlanrDbContext>();
        optionsBuilder.UseNpgsql(args.Length > 0 ? args[0] : "Host=development-event-planr-cluster.cluster-c8vnsblurrdp.us-east-1.rds.amazonaws.com;Port=5432;Username=master;Password=BMHqCFN%5WL7lHCx;Database=event_planr_db", o => o.UseNetTopologySuite());
        
        return new EventPlanrDbContext(optionsBuilder.Options);
    }
}
