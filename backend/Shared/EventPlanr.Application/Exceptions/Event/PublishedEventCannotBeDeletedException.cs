using EventPlanr.Application.Exceptions.Common;

namespace EventPlanr.Application.Exceptions.Event;

public class PublishedEventCannotBeDeletedException : DomainException
{
    public PublishedEventCannotBeDeletedException() : base(nameof(PublishedEventCannotBeDeletedException))
    {
    }
}
