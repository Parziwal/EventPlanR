namespace EventPlanr.Application.Contracts;

public interface IUserService
{
    Task AddOrganizationToUserClaimsAsync(Guid organizationId);
    Task RemoveOrganizationFromUserClaimsAsync(Guid organizationId);
}
