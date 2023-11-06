namespace EventPlanr.Application.Contracts;

public interface IUserContext
{
    public bool IsAuthenticated { get; }
    public string AccessToken { get; }
    public Guid UserId { get; }
    public string Email { get; }
    public string FirstName { get; }
    public string LastName { get; }
    public Guid? OrganizationId { get; }
    public List<string> OrganizationPolicies { get; }

}
