using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventLambda.Extensions;

public static class MinimalatrExtensions
{
    public static WebApplication MediateGet<TRequest>(this WebApplication app, string template) where TRequest : IBaseRequest
    {
        app.MapGet(template, async ([FromServices] IMediator mediator,
            [AsParameters] TRequest request) => await mediator.Send(request));
        return app;
    }
}
