using Amazon.Lambda.Core;
using System.Text.Json.Nodes;
using Microsoft.Extensions.DependencyInjection;
using EventPlanr.LambdaBase;
using MediatR;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace EventPlanr.UserReservedTicketOrder.Function;

public class Function
{
    private readonly ServiceProvider _serviceProvider;

    public Function()
    {
        var services = new ServiceCollection();
        services.AddLambdaFunctionServices();
        _serviceProvider = services.BuildServiceProvider();
    }

    public async Task FunctionHandler(JsonNode lambdaEvent, ILambdaContext context)
    {
        var mediator = _serviceProvider.GetRequiredService<IMediator>();

        context.Logger.Log(lambdaEvent.ToString());

        await Task.CompletedTask;
    }
}
