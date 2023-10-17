using EventPlanr.Application.Exceptions.Common;

namespace EventPlanr.Application.Exceptions.Event;

public class LiveEventCannotBeEditedException : DomainException
{
    public LiveEventCannotBeEditedException() : base(nameof(LiveEventCannotBeEditedException))
    {
    }
}
