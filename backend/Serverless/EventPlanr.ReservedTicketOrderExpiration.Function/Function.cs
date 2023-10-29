using Amazon.Lambda.Core;
using Amazon.Lambda.SQSEvents;
using EventPlanr.Application.Features.Order.Commands;
using EventPlanr.LambdaBase;
using MediatR;
using Microsoft.Extensions.DependencyInjection;


[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace EventPlanr.ReservedTicketOrderExpiration.Function;

public class Function
{
    private readonly ServiceProvider _serviceProvider;

    public Function()
    {
        var services = new ServiceCollection();
        services.AddLambdaFunctionServices();
        _serviceProvider = services.BuildServiceProvider();
    }

    public async Task FunctionHandler(SQSEvent evnt, ILambdaContext context)
    {
        foreach(var message in evnt.Records)
        {
            await ProcessMessageAsync(message, context);
        }
    }

    private async Task ProcessMessageAsync(SQSEvent.SQSMessage message, ILambdaContext context)
    {
        var mediator = _serviceProvider.GetRequiredService<IMediator>();

        var userId = new Guid(message.Body);
        await mediator.Send(new DeleteUserExpiredReservedTicketOrderCommand()
        {
            UserId = userId,
        });

        await Task.CompletedTask;
    }
}