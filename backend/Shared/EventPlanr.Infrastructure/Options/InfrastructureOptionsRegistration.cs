using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace EventPlanr.Infrastructure.Options;

public static class InfrastructureOptionsRegistration
{
    public static IServiceCollection AddInfrastructureOptions(this IServiceCollection services)
    {
        var configuration = services.BuildServiceProvider().GetRequiredService<IConfiguration>();

        services.Configure<DynamoDbTableOptions>(options => configuration.GetSection(nameof(DynamoDbTableOptions)).Bind(options));

        return services;
    }
}
