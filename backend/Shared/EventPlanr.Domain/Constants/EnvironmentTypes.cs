namespace EventPlanr.Domain.Constants;

public static class EnvironmentTypes
{
    public const string DevelopmentLocal = "DevelopmentLocal";
    public const string Development = "Development";
    public const string Production = "Production";

    public static bool IsDevelopmentLocal()
    {
        return Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == DevelopmentLocal;
    }

    public static bool IsDevelopment()
    {
        return Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == Development;
    }

    public static bool IsProduction()
    {
        return Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == Production;
    }
}
