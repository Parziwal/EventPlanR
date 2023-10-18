using Microsoft.Extensions.Configuration;

namespace EventPlanr.LambdaBase.Configuration;
public static class ConfigartionExtensions
{
    public static IConfigurationBuilder AddConfigurationSettings(this IConfigurationBuilder builder)
    {
        var environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Development";

        return builder
            .AddSystemsManager($"/{environment.ToLower()}/event_planr")
            .AddEnvironmentVariables();
    }
}
