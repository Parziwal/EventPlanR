using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Contracts;

public interface IUserClaimService
{
    Task<UserClaimEntity> GetUserClaimAsync(Guid userId);
    Task PutOrganizationToUserAsync(Guid userId, OrganizationPolicyEntity organization);
    Task RemoveOrganizationFromUserAsync(Guid userId, Guid organizationId);
    Task SetUserCurrentOrganization(Guid userId, Guid organizationId);
}
