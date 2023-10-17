using EventPlanr.Application.Exceptions.Common;

namespace EventPlanr.Application.Exceptions.Organization;

public class UserNotBelongToOrganizationException : DomainException
{
    public UserNotBelongToOrganizationException() :
        base(nameof(UserNotBelongToOrganizationException))
    {
    }
}
