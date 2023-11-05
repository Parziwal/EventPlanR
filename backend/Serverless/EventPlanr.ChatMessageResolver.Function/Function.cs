using Amazon.Lambda.Core;
using Microsoft.Extensions.DependencyInjection;
using EventPlanr.LambdaBase;
using EventPlanr.ChatMessageResolver.Function.Models;
using MediatR;
using EventPlanr.Application.Features.Chat.Queries;
using EventPlanr.Application.Features.Chat.Commands;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace EventPlanr.ChatMessageResolver.Function;

public class Function
{
    private readonly ServiceProvider _serviceProvider;

    public Function()
    {
        var services = new ServiceCollection();
        services.AddLambdaFunctionServices();
        _serviceProvider = services.BuildServiceProvider();
    }
    public async Task<object> FunctionHandler(ChatMessageRequest request, ILambdaContext context)
    {
        var sender = _serviceProvider.GetRequiredService<ISender>();

        return request.Field switch
        {
            "getChatMessages" => await sender.Send(new GetChatMessagesQuery()
            {
                ChatId = request.Arguments.ChatId,
                UserId = request.UserId,
            }),
            "createMessage" => await sender.Send(new CreateChatMessageCommand()
            {
                ChatId = request.Arguments.ChatId,
                UserId = request.UserId,
                Content = request.Arguments.Content!,
            }),
            _ => new object(),
        };
    }
}
