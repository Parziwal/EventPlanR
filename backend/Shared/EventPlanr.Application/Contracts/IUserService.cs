namespace EventPlanr.Application.Contracts;

public interface IUserService
{
    Task AddOrganizationToUserClaimsAsync(Guid userId, Guid organizationId);
    Task RemoveOrganizationFromUserClaimsAsync(Guid userId, Guid organizationId);
    Task<List<Guid>> GetUserOrganizationsAsync(Guid userId);
}
