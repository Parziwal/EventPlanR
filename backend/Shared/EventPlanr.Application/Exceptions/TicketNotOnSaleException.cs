using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Exceptions;

public class TicketNotOnSaleException : Exception
{
    public TicketNotOnSaleException(TicketEntity ticket):
        base($"The ticket with the identifier {ticket.Id} not on sale before {ticket.SaleStarts} or after {ticket.SaleEnds}")
    {
        
    }
}
