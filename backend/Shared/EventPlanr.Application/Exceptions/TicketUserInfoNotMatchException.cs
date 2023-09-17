using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Exceptions;

public class TicketUserInfoNotMatchException : Exception
{
    public TicketUserInfoNotMatchException(Guid ticketId) :
        base($"The ticket(s) info doesn't match with the reserved ticket(s) data on {ticketId} ticket identifier")
    {
        
    }
}
