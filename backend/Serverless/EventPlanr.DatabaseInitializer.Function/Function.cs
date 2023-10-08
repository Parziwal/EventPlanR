using Amazon.Lambda.Core;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using EventPlanr.Application;
using EventPlanr.Infrastructure;
using EventPlanr.Configuration;
using EventPlanr.Infrastructure.Persistance;
using System.Text.Json.Nodes;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace EventPlanr.DatabaseInitializer.Function;

public class Function
{
    private readonly ServiceCollection _services;

    public Function()
    {
        _services = new ServiceCollection();
        var configuration = new ConfigurationBuilder()
            .AddConfigurationSettings()
            .Build();
        _services.AddSingleton<IConfiguration>(configuration);
        _services.AddApplicationServices();
        _services.AddInfrastructureServices(configuration);
    }

    public async Task FunctionHandler(JsonNode lambdaEvent, ILambdaContext context)
    {
        await _services.InitializeDatabaseAsync();
    }
}
