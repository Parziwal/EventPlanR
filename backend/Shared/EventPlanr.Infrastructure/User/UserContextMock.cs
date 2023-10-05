using EventPlanr.Application.Contracts;

namespace EventPlanr.Infrastructure.User;

public class UserContextMock : IUserContext
{
    public Guid UserId => new Guid("a5b10234-d908-47ca-91b3-5b877ca761a2");

    public string Email => "test.elek@email.hu";

    public string FirstName => "Elek";

    public string LastName => "Test";

    public List<Guid> OrganizationIds => new List<Guid>();
}
