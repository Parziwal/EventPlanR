using EventPlanr.Application.Exceptions.Common;

namespace EventPlanr.Application.Exceptions.Organization;

public class OrganizationWithUpcomingEventCannotBeDeletedException : DomainException
{
    public OrganizationWithUpcomingEventCannotBeDeletedException() : base(nameof(OrganizationWithUpcomingEventCannotBeDeletedException))
    {
    }
}
