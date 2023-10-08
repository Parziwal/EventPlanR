using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions.Common;
using EventPlanr.Application.Security;
using MediatR;
using System.Reflection;

namespace EventPlanr.Application.Behaviour;

public class AuthorizationBehaviour<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse> where TRequest : notnull
{
    private readonly IUserContext _user;

    public AuthorizationBehaviour(
        IUserContext user)
    {
        _user = user;
    }

    public async Task<TResponse> Handle(TRequest request, RequestHandlerDelegate<TResponse> next, CancellationToken cancellationToken)
    {
        var authorizeAttributes = request.GetType().GetCustomAttributes<AuthorizeAttribute>();

        if (authorizeAttributes.Any())
        {
            if (!_user.IsAuthenticated)
            {
                throw new UnauthorizedAccessException();
            }

            var authorizeAttributesWithPolicies = authorizeAttributes.Where(a => !string.IsNullOrWhiteSpace(a.OrganizationPolicy));
            if (authorizeAttributesWithPolicies.Any())
            {
                foreach (var policy in authorizeAttributesWithPolicies.Select(a => a.OrganizationPolicy))
                {
                    var authorized = _user.OrganizationPolicies.Contains(policy);

                    if (!authorized)
                    {
                        throw new ForbiddenException();
                    }
                }
            }
        }

        return await next();
    }
}
