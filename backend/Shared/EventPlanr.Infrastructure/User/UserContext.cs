using EventPlanr.Application.Contracts;
using Microsoft.AspNetCore.Http;
using System.Security.Claims;

namespace EventPlanr.Infrastructure.User;

public class UserContext : IUserContext
{
    public readonly HttpContext _httpContext;

    public UserContext(IHttpContextAccessor httpContextAccessor)
    {
        _httpContext = httpContextAccessor.HttpContext!;
    }

    public string UserId => _httpContext.User.FindFirst(ClaimTypes.NameIdentifier).Value;

    public string Email => _httpContext.User.Claims.FirstOrDefault(c => c.Type == "email").Value;

    public string FirstName => _httpContext.User.Claims.FirstOrDefault(c => c.Type == "first_name").Value;

    public string LastName => _httpContext.User.Claims.FirstOrDefault(c => c.Type == "last_name").Value;

    public List<string> OrganizationIds => new List<string>();
}
