using EventPlanr.Application.Contracts;
using Microsoft.AspNetCore.Http;

namespace EventPlanr.Infrastructure.User;

public class UserContext : IUserContext
{
    public readonly IHttpContextAccessor _httpContext;

    public UserContext(IHttpContextAccessor httpContext)
    {
        _httpContext = httpContext;
    }

    public string UserId => throw new NotImplementedException();

    public string Email => throw new NotImplementedException();

    public string FirstName => throw new NotImplementedException();

    public string LastName => throw new NotImplementedException();

    public List<string> OrganizationIds => throw new NotImplementedException();
}
