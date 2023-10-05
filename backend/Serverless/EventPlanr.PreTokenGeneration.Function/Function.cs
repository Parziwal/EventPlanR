using Amazon.Lambda.Core;
using Microsoft.Extensions.DependencyInjection;
using EventPlanr.Application;
using EventPlanr.Infrastructure;
using Microsoft.Extensions.Configuration;
using EventPlanr.Configuration;
using MediatR;
using EventPlanr.Application.Features.Organization.Queries;
using System.Text.Json.Nodes;
using System.Text.Json;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace EventPlanr.PreTokenGeneration.Function;

public class Function
{
    private readonly ServiceProvider _serviceProvider;

    public Function()
    {
        var services = new ServiceCollection();
        var configuration = new ConfigurationBuilder()
            .AddConfigurationSettings()
            .Build();
        services.AddSingleton<IConfiguration>(configuration);
        services.AddApplicationServices();
        services.AddInfrastructureServices(configuration);
        _serviceProvider = services.BuildServiceProvider();
    }

    public async Task<JsonNode> FunctionHandler(JsonNode lambdaEvent, ILambdaContext context)
    {
        var mediator = _serviceProvider.GetRequiredService<IMediator>();
        var organizationIds = await mediator.Send(new GetUserOrganizationClaimsQuery()
        {
            UserId = new Guid(lambdaEvent["request"]!["userAttributes"]!["sub"]!.GetValue<string>()),
        });
        lambdaEvent["response"]!["claimsOverrideDetails"] = JsonValue.Create(new
            { 
                claimsToAddOrOverride = new { organization_ids = JsonSerializer.Serialize(organizationIds) }
            });

        return lambdaEvent;
    }
}
