using EventPlanr.Application.Models.Order;

namespace EventPlanr.Application.Contracts;

public interface ITicketService
{
    Task StoreReservedTicketsAsync(Guid userId, List<StoreReservedTicketDto> reserveTickets);
    Task<List<StoreReservedTicketDto>> GetUserReservedTicketsAsync(Guid userId);
}
