using Amazon.Lambda.Core;
using Microsoft.Extensions.DependencyInjection;
using EventPlanr.LambdaBase;
using MediatR;
using System.Text.Json.Nodes;
using System.Text.Json;
using EventPlanr.Application.Features.User.Queries;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace EventPlanr.PreTokenGeneration.Function;

public class Function
{
    private readonly ServiceProvider _serviceProvider;

    public Function()
    {
        var services = new ServiceCollection();
        services.AddLambdaFunctionServices();
        _serviceProvider = services.BuildServiceProvider();
    }

    public async Task<JsonNode> FunctionHandler(JsonNode lambdaEvent, ILambdaContext context)
    {
        var mediator = _serviceProvider.GetRequiredService<IMediator>();
        var userClaim = await mediator.Send(new GetUserClaimQuery()
        {
            UserId = new Guid(lambdaEvent["request"]!["userAttributes"]!["sub"]!.GetValue<string>()),
        });

        if (userClaim.OrganizationId == null)
        {
            return lambdaEvent;
        }

        lambdaEvent["response"]!["claimsOverrideDetails"] = JsonValue.Create(new
            { 
                claimsToAddOrOverride = new {
                    organization_id = userClaim.OrganizationId.ToString(),
                    organization_policies = JsonSerializer.Serialize(userClaim.OrganizationPolicies),
                }
            });

        return lambdaEvent;
    }
}
