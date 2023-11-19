using EventPlanr.LambdaBase.Configuration;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using EventPlanr.Application;
using EventPlanr.Infrastructure;
using EventPlanr.LambdaBase.ExceptionHandling;
using EventPlanr.LambdaBase.Swagger;
using System.Text.Json.Serialization;
using Microsoft.Extensions.Options;
using System.Globalization;
using Microsoft.AspNetCore.Localization;

namespace EventPlanr.LambdaBase;

public static class ProgramExtensions
{
    public static IServiceCollection AddCommonAppServices(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddApplicationServices();
        services.AddInfrastructureServices(configuration);

        return services;
    }

    public static IServiceCollection AddLambdaFunctionServices(this IServiceCollection services)
    {
        var configuration = new ConfigurationBuilder()
            .AddConfigurationSettings()
            .Build();

        services.AddSingleton<IConfiguration>(configuration);
        services.AddCommonAppServices(configuration);

        return services;
    }

    public static WebApplicationBuilder AddServerlessLambdaServices(this WebApplicationBuilder builder)
    {
        builder.Services
            .AddControllers()
            .AddJsonOptions(options => options.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter()));
        builder.Services.AddAWSLambdaHosting(LambdaEventSource.HttpApi);

        builder.Configuration.AddConfigurationSettings();

        builder.Services.AddCommonAppServices(builder.Configuration);
        builder.Services.AddCustomExceptionHandling();
        builder.Services.AddSwagger();

        builder.Services.AddLocalization();
        builder.Services.Configure<RequestLocalizationOptions>(options =>
        {
            var supportedCultures = new List<CultureInfo>
            {
                new CultureInfo("en"),
                new CultureInfo("hu")
            };
            options.DefaultRequestCulture = new RequestCulture("en");
            options.SupportedCultures = supportedCultures;
            options.SupportedUICultures = supportedCultures;
        });

        return builder;
    }

    public static WebApplication UseServerlessLambda(this WebApplication app)
    {
        app.UseCustomExceptionHandling();
        app.UseSwagger();
        app.MapControllers();
        app.UseRequestLocalization();

        return app;
    }
}
