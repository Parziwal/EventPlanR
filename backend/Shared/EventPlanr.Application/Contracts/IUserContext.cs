using System.Net.Http;

namespace EventPlanr.Application.Contracts;

public interface IUserContext
{
    public Guid UserId { get; }
    public string Email { get; }
    public string FirstName { get; }
    public string LastName { get; }
    public List<Guid> OrganizationIds { get; }
}
