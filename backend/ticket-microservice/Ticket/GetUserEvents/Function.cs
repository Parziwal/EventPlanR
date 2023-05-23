using Amazon.Lambda.Core;
using MediatR;
using Microsoft.Extensions.DependencyInjection;
using Ticket.Application;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]
namespace GetUserEvents;

public class Function
{
    private readonly ServiceProvider _serviceProvider;

    public Function()
    {
        var services = new ServiceCollection();
        services.AddApplicationServices();
        _serviceProvider = services.BuildServiceProvider();
    }

    public async Task<List<string>> FunctionHandler(string userId, ILambdaContext context)
    {
        var mediator = _serviceProvider.GetRequiredService<IMediator>();
        return await mediator.Send(new GetUserEventIdsQuery(userId));
    }
}
