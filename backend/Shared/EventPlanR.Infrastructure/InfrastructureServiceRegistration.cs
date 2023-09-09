using EventPlanr.Domain.Repositories;
using EventPlanr.Infrastructure.Persistance;
using EventPlanr.Infrastructure.Persistance.Interceptors;
using EventPlanr.Infrastructure.Repositories;
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
            options.UseNpgsql(configuration.GetConnectionString("EventDb"));
        });
        services.AddScoped<DatabaseInitializer>();

        services.AddScoped<IEventRepository, EventRepository>();

        //services.Configure<LambdaFunctionOptions>(options => configuration.GetSection(nameof(LambdaFunctionOptions)).Bind(options));

        return services;
    }
}
