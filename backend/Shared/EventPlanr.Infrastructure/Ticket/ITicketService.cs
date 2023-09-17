using EventPlanr.Application.Contracts;
using EventPlanr.Application.Models.Ticket;

namespace EventPlanr.Infrastructure.Ticket;

public class TicketService : ITicketService
{
    public Task<List<StoreReservedTicketDto>> GetUserReservedTicketsAsync(string userId)
    {
        throw new NotImplementedException();
    }

    public Task StoreReservedTicketsAsync(string userId, List<StoreReservedTicketDto> reserveTickets)
    {
        throw new NotImplementedException();
    }
}
