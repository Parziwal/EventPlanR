using Event.Application.Contracts;
using Event.Domain.Options;
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
            opts.UseNpgsql(configuration.GetConnectionString("EventDb"),
            npsql => npsql.UseNetTopologySuite())
        );

        services.AddTransient<IEventRepository, EventRepository>();

        services.Configure<LambdaFunctionOptions>(options => configuration.GetSection(nameof(LambdaFunctionOptions)).Bind(options));

        return services;
    }
}
