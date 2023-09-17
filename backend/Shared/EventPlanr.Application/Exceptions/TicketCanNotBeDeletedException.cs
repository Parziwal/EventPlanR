namespace EventPlanr.Application.Exceptions;

public class TicketCanNotBeDeletedException : Exception
{
    public TicketCanNotBeDeletedException(Guid ticketId) :
        base($"Ticket with identifier {ticketId} cannot be deleted because it has orders.")
    {
    }
}
