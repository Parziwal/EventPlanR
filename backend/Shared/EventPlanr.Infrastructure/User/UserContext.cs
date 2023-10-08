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

    public bool IsAuthenticated => _httpContext.User?.Identity?.IsAuthenticated ?? false;

    public Guid UserId => Guid.Parse(_httpContext.User.FindFirstValue("sub"));

    public string Email => _httpContext.User.FindFirstValue("email");

    public string FirstName => _httpContext.User.FindFirstValue("given_name");

    public string LastName => _httpContext.User.FindFirstValue("family_name");

    public Guid? OrganizationId
    {
        get
        {
            var organizationId = _httpContext.User.Claims.FirstOrDefault(c => c.Type == "organization_id");

            if (organizationId != null)
            {
                return new Guid(organizationId.Value);
            }

            return null;
        }
    }

    public List<string> OrganizationPolicies
    {
        get
        {
            var organizationPolicies = _httpContext.User.Claims.FirstOrDefault(c => c.Type == "organization_policies");

            if (organizationPolicies != null)
            {
                return JsonSerializer.Deserialize<List<string>>(organizationPolicies.Value)!;
            }

            return new List<string>();
        }
    }
}
