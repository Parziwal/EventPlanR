using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Contracts;

public interface ITicketOrderService
{
    Task<List<ReservedTicketEntity>> GetUserReservedTicketsAsync(Guid userId, bool onlyIfExpired = false);
    Task<DateTimeOffset> ReserveTicketsAsync(Guid userId, List<ReservedTicketEntity> reserveTickets);
    Task RemoveUserExpiredTicketAsnyc(Guid userId);
}
