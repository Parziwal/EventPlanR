namespace EventPlanr.Domain.Constants;

public static class EnvironmentType
{
    public const string DEVELOPMENT_LOCAL = "Development_Local";
    public const string DEVELOPMENT = "Development";
    public const string PRODUCTION = "Production";

    public static bool IsDevelopmentLocal()
    {
        return Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == DEVELOPMENT_LOCAL;
    }

    public static bool IsDevelopment()
    {
        return Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == DEVELOPMENT;
    }

    public static bool IsProduction()
    {
        return Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == PRODUCTION;
    }
}
