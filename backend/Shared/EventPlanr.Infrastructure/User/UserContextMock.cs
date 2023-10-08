using EventPlanr.Application.Contracts;
using EventPlanr.Domain.Constants;

namespace EventPlanr.Infrastructure.User;

public class UserContextMock : IUserContext
{
    public bool IsAuthenticated => true;

    public Guid UserId => new Guid("a5b10234-d908-47ca-91b3-5b877ca761a2");

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
