using EventPlanr.Application.Contracts;
using EventPlanr.Domain.Constants;

namespace EventPlanr.Infrastructure.User;

public class UserContextMock : IUserContext
{
    public bool IsAuthenticated => true;

    public string AccessToken => "Bearer token";

    public Guid UserId => new Guid("b21f187d-4726-41b3-b950-5c599b1b6a6c");

    public string Email => "test.elek@email.hu";

    public string FirstName => "Elek";

    public string LastName => "Test";

    public Guid? OrganizationId => new Guid("d2a43923-5b06-40ef-8f7d-ecec6242a64b");

    public List<string> OrganizationPolicies => new List<string>()
    {
        Domain.Constants.OrganizationPolicies.OrganizationManage,
        Domain.Constants.OrganizationPolicies.OrganizationEventManage,
        Domain.Constants.OrganizationPolicies.OrganizationEventView,
        Domain.Constants.OrganizationPolicies.OrganizationEventManage,
    };
}
