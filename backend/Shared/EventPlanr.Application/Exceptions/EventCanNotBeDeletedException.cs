namespace EventPlanr.Application.Exceptions;

public class EventCanNotBeDeletedException : Exception
{
    public EventCanNotBeDeletedException(Guid eventId) :
        base($"Event with identifier {eventId} cannot be deleted because it has orders.")
    {
        
    }
}
