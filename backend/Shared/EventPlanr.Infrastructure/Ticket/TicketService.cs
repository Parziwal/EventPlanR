using EventPlanr.Application.Contracts;
using EventPlanr.Application.Models.Order;

namespace EventPlanr.Infrastructure.Ticket;

public class TicketService : ITicketService
{
    public Task<List<StoreReservedTicketDto>> GetUserReservedTicketsAsync(Guid userId)
    {
        throw new NotImplementedException();
    }

    public Task StoreReservedTicketsAsync(Guid userId, List<StoreReservedTicketDto> reserveTickets)
    {
        throw new NotImplementedException();
    }
}
