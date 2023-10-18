using Amazon.Lambda.Core;
using Microsoft.Extensions.DependencyInjection;
using EventPlanr.LambdaBase;
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
        _services.AddLambdaFunctionServices();
    }

    public async Task FunctionHandler(JsonNode lambdaEvent, ILambdaContext context)
    {
        await _services.InitializeDatabaseAsync();
    }
}
