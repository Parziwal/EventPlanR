using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Exceptions;

public class TicketSaleDatesNotBetweenEventDateException : Exception
{
    public TicketSaleDatesNotBetweenEventDateException(DateTimeOffset saleStarts, DateTimeOffset saleEnds, DateTimeOffset eventFrom, DateTimeOffset evenTo) :
        base($"The ticket sale dates {saleStarts} - {saleEnds} are not between event dates {eventFrom} - {evenTo}")
    {
        
    }
}
