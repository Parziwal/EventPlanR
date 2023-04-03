using Event.Application.Contracts;
using Event.Infrastructure.Persistance;
using Event.Infrastructure.Repository;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Event.Infrastructure;

public static class InfrastructureServiceRegistration
{
    public static IServiceCollection AddInfrastructureServices(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddDbContext<EventDbContext>(opts =>
            opts.UseNpgsql(configuration.GetConnectionString("AppDb")),
            ServiceLifetime.Transient);

        services.AddTransient<IEventRepository, EventRepository>();

        return services;
    }
}
