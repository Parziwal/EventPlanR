using EventPlanr.Application.Exceptions;
using EventPlanr.Domain.Constants;
using Hellang.Middleware.ProblemDetails;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using System.Text.Json;

namespace EventPlanr.LambdaBase.ExceptionHandling;

public static class ExceptionHandlingExtensions
{
    public static IServiceCollection AddCustomExceptionHandling(this IServiceCollection services)
    {
        services.AddProblemDetails(setup =>
        {
            setup.IncludeExceptionDetails = (ctx, env) => EnvironmentTypes.IsDevelopment();

            setup.Map<EntityNotFoundException>((context, exception) =>
            {
                var problemDetails = StatusCodeProblemDetails.Create(StatusCodes.Status404NotFound);
                problemDetails.Title = exception.Message;
                return problemDetails;
            });
            setup.Map<DomainException>((context, exception) =>
            {
                var problemDetails = StatusCodeProblemDetails.Create(StatusCodes.Status400BadRequest);
                problemDetails.Title = exception.Message;
                return problemDetails;
            });
            setup.Map<ForbiddenException>((context, exception) =>
            {
                var problemDetails = StatusCodeProblemDetails.Create(StatusCodes.Status403Forbidden);
                problemDetails.Title = exception.Message;
                return problemDetails;
            });
            setup.Map<ValidationException>((context, exception) =>
            {
                var problemDetails = StatusCodeProblemDetails.Create(StatusCodes.Status400BadRequest);
                problemDetails.Title = exception.Message;
                problemDetails.Detail = JsonSerializer.Serialize(exception.Errors);
                return problemDetails;
            });
        });

        return services;
    }

    public static IApplicationBuilder UseCustomExceptionHandling(this IApplicationBuilder app)
    {
        app.UseProblemDetails();

        return app;
    }
}
