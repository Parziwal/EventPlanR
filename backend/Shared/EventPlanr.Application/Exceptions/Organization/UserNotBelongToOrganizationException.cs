using EventPlanr.Application.Exceptions.Common;

namespace EventPlanr.Application.Exceptions.Organization;

public class UserNotBelongToOrganizationException : ForbiddenException
{
    public UserNotBelongToOrganizationException() :
        base(nameof(UserNotBelongToOrganizationException))
    {
    }
}
