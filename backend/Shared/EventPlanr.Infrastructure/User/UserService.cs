using EventPlanr.Application.Contracts;

namespace EventPlanr.Infrastructure.User;

public class UserService : IUserService
{
    public Task AddOrganizationToUserClaims(Guid organizationId)
    {
        throw new NotImplementedException();
    }

    public Task RemoveOrganizationToUserClaims(Guid organizationId)
    {
        throw new NotImplementedException();
    }
}
