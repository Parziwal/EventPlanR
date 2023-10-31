using Amazon.CognitoIdentityProvider;
using Amazon.DynamoDBv2;
using Amazon.SQS;
using EventPlanr.Application.Contracts;
using EventPlanr.Domain.Constants;
using EventPlanr.Infrastructure.Chat;
using EventPlanr.Infrastructure.Options;
using EventPlanr.Infrastructure.Persistance;
using EventPlanr.Infrastructure.Persistance.Interceptors;
using EventPlanr.Infrastructure.Ticket;
using EventPlanr.Infrastructure.User;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace EventPlanr.Infrastructure;

public static class InfrastructureServiceRegistration
{
    public static IServiceCollection AddInfrastructureServices(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddInfrastructureOptions();

        services.AddScoped<ISaveChangesInterceptor, AuditableEntityInterceptor>();
        services.AddScoped<ISaveChangesInterceptor, SoftDeleteInterceptor>();
        services.AddDbContext<EventPlanrDbContext>((sp, options) =>
        {
            options.AddInterceptors(sp.GetServices<ISaveChangesInterceptor>());
            options.UseNpgsql(configuration.GetConnectionString("EventPlanrDb"), o => o.UseNetTopologySuite());
        });
        services.AddScoped<IApplicationDbContext>(provider => provider.GetRequiredService<EventPlanrDbContext>());
        services.AddScoped<DatabaseInitializer>();

        services.AddScoped<IAmazonDynamoDB, AmazonDynamoDBClient>();
        services.AddScoped<IAmazonSQS, AmazonSQSClient>();
        services.AddScoped<IAmazonCognitoIdentityProvider, AmazonCognitoIdentityProviderClient>();

        services.AddHttpContextAccessor();

        services.AddScoped<IUserContext, UserContext>();
        services.AddTransient<IUserService, UserService>();
        services.AddTransient<IUserClaimService, UserClaimService>();
        services.AddTransient<ITicketOrderService, TicketOrderService>();
        services.AddTransient<IChatService, ChatService>();

        if (EnvironmentTypes.IsLocal())
        {
            services.AddScoped<IUserContext, UserContextMock>();
        }

        return services;
    }
}