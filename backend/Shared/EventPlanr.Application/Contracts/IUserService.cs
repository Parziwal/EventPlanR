namespace EventPlanr.Application.Contracts;

public interface IUserService
{
    Task AddOrganizationToUserClaims(Guid organizationId);
    Task RemoveOrganizationToUserClaims(Guid organizationId);
}
