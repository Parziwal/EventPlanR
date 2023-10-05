using EventPlanr.Application.Contracts;
using Microsoft.AspNetCore.Http;
using System.Security.Claims;
using System.Text.Json;

namespace EventPlanr.Infrastructure.User;

public class UserContext : IUserContext
{
    private readonly HttpContext _httpContext;

    public UserContext(IHttpContextAccessor httpContextAccessor)
    {
        _httpContext = httpContextAccessor.HttpContext!;
    }

    public Guid UserId => Guid.Parse(_httpContext.User.FindFirstValue("sub"));

    public string Email => _httpContext.User.FindFirstValue("email");

    public string FirstName => _httpContext.User.FindFirstValue("given_name");

    public string LastName => _httpContext.User.FindFirstValue("family_name");

    public List<Guid> OrganizationIds {
        get
        {
            var organizationClaim = _httpContext.User.Claims.FirstOrDefault(c => c.Type == "organization_ids");

            if (organizationClaim != null)
            {
                return JsonSerializer.Deserialize<List<Guid>>(organizationClaim.Value)!;
            }

            return new List<Guid>();
        }
    }
}
