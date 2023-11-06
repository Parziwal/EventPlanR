using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace EventPlanr.Infrastructure.Options;

public static class InfrastructureOptionsRegistration
{
    public static IServiceCollection AddInfrastructureOptions(this IServiceCollection services)
    {
        var configuration = services.BuildServiceProvider().GetRequiredService<IConfiguration>();

        services.Configure<DynamoDbTableOptions>(options => configuration.GetSection(nameof(DynamoDbTableOptions)).Bind(options));
        services.Configure<CognitoUserPoolOptions>(options => configuration.GetSection(nameof(CognitoUserPoolOptions)).Bind(options));
        services.Configure<SqsQueueOptions>(options => configuration.GetSection(nameof(SqsQueueOptions)).Bind(options));
        services.Configure<S3BucketOptions>(options => configuration.GetSection(nameof(S3BucketOptions)).Bind(options));

        return services;
    }
}
