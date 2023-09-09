using EventPlanR.Domain.Repositories;
using EventPlanR.Infrastructure.Persistance;
using EventPlanR.Infrastructure.Persistance.Interceptors;
using EventPlanR.Infrastructure.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace EventPlanR.Infrastructure;

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
