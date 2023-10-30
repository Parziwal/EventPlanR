using EventPlanr.Application.Contracts;
using Microsoft.AspNetCore.Http;
using System.Security.Claims;
using System.Text.Json;

namespace EventPlanr.Infrastructure.User;

public class UserContext : IUserContext
{
    private readonly IHttpContextAccessor _http;

    public UserContext(IHttpContextAccessor httpContextAccessor)
    {
        _http = httpContextAccessor;
    }

    public bool IsAuthenticated => _http.HttpContext?.User?.Identity?.IsAuthenticated ?? false;

    public Guid UserId => Guid.Parse(_http.HttpContext!.User.FindFirstValue("sub"));

    public string Email => _http.HttpContext!.User.FindFirstValue("email");

    public string FirstName => _http.HttpContext!.User.FindFirstValue("given_name");

    public string LastName => _http.HttpContext!.User.FindFirstValue("family_name");

    public Guid? OrganizationId
    {
        get
        {
            var organizationId = _http.HttpContext!.User.Claims.FirstOrDefault(c => c.Type == "organization_id");

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
            var organizationPolicies = _http.HttpContext!.User.Claims.FirstOrDefault(c => c.Type == "organization_policies");

            if (organizationPolicies != null)
            {
                return JsonSerializer.Deserialize<List<string>>(organizationPolicies.Value)!;
            }

            return new List<string>();
        }
    }
}
