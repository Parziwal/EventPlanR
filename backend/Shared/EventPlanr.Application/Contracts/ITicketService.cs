using EventPlanr.Application.Models.Order;

namespace EventPlanr.Application.Contracts;

public interface ITicketService
{
    Task StoreReservedTicketsAsync(string userId, List<StoreReservedTicketDto> reserveTickets);
    Task<List<StoreReservedTicketDto>> GetUserReservedTicketsAsync(string userId);
}
