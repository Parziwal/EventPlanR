namespace EventPlanr.Application.Contracts;

public interface IUserContext
{
    public string UserId { get; }
    public string Email { get; }
    public string FirstName { get; }
    public string LastName { get; }
    public List<string> OrganizationIds { get; }
}
