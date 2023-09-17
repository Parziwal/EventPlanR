using EventPlanr.Application.Contracts;

namespace EventPlanr.Infrastructure.User;

public class UserService : IUserService
{
    public Task AddOrganizationToUserClaimsAsync(Guid organizationId)
    {
        throw new NotImplementedException();
    }

    public Task RemoveOrganizationFromUserClaimsAsync(Guid organizationId)
    {
        throw new NotImplementedException();
    }
}
