using EventPlanr.Application.Contracts;
using EventPlanr.Infrastructure.Persistance;
using EventPlanr.Infrastructure.Persistance.Interceptors;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace EventPlanr.Infrastructure;

public static class InfrastructureServiceRegistration
{
    public static IServiceCollection AddInfrastructureServices(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddScoped<ISaveChangesInterceptor, AuditableEntityInterceptor>();
        services.AddDbContext<EventPlanrDbContext>((sp, options) =>
        {
            options.AddInterceptors(sp.GetServices<ISaveChangesInterceptor>());
            options.UseNpgsql(configuration.GetConnectionString("EventPlanrDb"));
        });
        services.AddScoped<IApplicationDbContext>(provider => provider.GetRequiredService<EventPlanrDbContext>());
        services.AddScoped<DatabaseInitializer>();

        return services;
    }
}
