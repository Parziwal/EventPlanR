namespace EventPlanr.Application.Exceptions;

public class UserNotBelongToOrganizationException : Exception
{
    public UserNotBelongToOrganizationException(string userId, string organizationId):
        base($"The user with the identifier {userId} does not belong to the organization with the identifier {organizationId}")
    {
        
    }
}
