namespace EventPlanr.Domain.Constants;

public static class EnvironmentTypes
{
    public const string Development = "Development";
    public const string Production = "Production";

    public static bool IsDevelopment()
    {
        return Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == Development;
    }

    public static bool IsProduction()
    {
        return Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == Production;
    }

    public static bool IsLocal()
    {
        return string.IsNullOrEmpty(Environment.GetEnvironmentVariable("AWS_LAMBDA_FUNCTION_NAME"));
    }
}
