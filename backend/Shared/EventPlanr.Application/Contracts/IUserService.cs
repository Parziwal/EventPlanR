using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Contracts;

public interface IUserService
{
    public Task<Guid?> GetUserIdByEmail(string email);
    public Task<UserEntity> GetUserById(Guid userId);
}
