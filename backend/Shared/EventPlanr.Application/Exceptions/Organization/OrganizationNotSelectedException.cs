using EventPlanr.Application.Exceptions.Common;

namespace EventPlanr.Application.Exceptions.Organization;
public class OrganizationNotSelectedException : DomainException
{
    public OrganizationNotSelectedException() : base("OrganizationNotSelected")
    {
    }
}
