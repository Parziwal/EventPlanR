using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Exceptions;

public class NotEnoughTicketException : Exception
{
    public NotEnoughTicketException(TicketEntity ticket) :
        base($"There are not enough tickets with the identifier {ticket.Id}")
    {
    }
}
