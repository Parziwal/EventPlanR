using Amazon.Lambda.Core;
using Microsoft.Extensions.DependencyInjection;
using EventPlanr.LambdaBase;
using EventPlanr.ChatMessageResolver.Function.Models;
using System.Text.Json;

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
    public object FunctionHandler(ChatMessageRequest request, ILambdaContext context)
    {
        context.Logger.Log(JsonSerializer.Serialize(request));

        return request.Field switch
        {
            "getConversationMessages" => new {
                ConversationId = request.Arguments.ConversationId,
                Content = "Test",
                CreatedAt = DateTime.UtcNow.ToString(),
                Sender = "Test",
            },
            "createMessage" => new
            {
                ConversationId = request.Arguments.ConversationId,
                Content = request.Arguments.Content!,
                CreatedAt = DateTime.UtcNow,
                Sender = "Test",
            },
            _ => new object(),
        };
    }
}
