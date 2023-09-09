using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using EventPlanR.Configuration;

namespace EventPlanR.Infrastructure.Persistance;
public class EventPlanrContextFactory : IDesignTimeDbContextFactory<EventPlanrDbContext>
{
    public EventPlanrDbContext CreateDbContext(string[] args)
    {
        var configuration = new ConfigurationBuilder()
            .AddConfigurationSettings()
            .Build();
        var optionsBuilder = new DbContextOptionsBuilder<EventPlanrDbContext>();
        optionsBuilder.UseNpgsql(configuration.GetConnectionString("EventPlanrDb"));

        return new EventPlanrDbContext(optionsBuilder.Options);
    }
}
