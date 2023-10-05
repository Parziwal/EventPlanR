using Microsoft.Extensions.Configuration;

namespace EventPlanr.Configuration;

public static class ConfigurationServiceRegistration
{
    public static IConfigurationBuilder AddConfigurationSettings(this IConfigurationBuilder builder)
    {
        var currentDirectory = Directory.GetCurrentDirectory();
        var rootDirectory = currentDirectory.Substring(0, currentDirectory.IndexOf("backend") + 7);
        var configurationDirectory  = Path.Combine(rootDirectory, "Shared", "EventPlanr.Configuration");
        var environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Development";

        return builder.AddJsonFile(Path.Combine(configurationDirectory, "appsettings.json"), optional: true, reloadOnChange: true)
            .AddJsonFile(Path.Combine(configurationDirectory, $"appsettings.{environment}.json"), optional: true, reloadOnChange: true)
            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
            .AddJsonFile($"appsettings.{environment}.json", optional: true, reloadOnChange: true)
            .AddEnvironmentVariables()
            .AddSystemsManager($"/{environment.ToLower()}/event_planr");
    }
}
