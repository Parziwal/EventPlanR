using EventPlanr.Application.Models.Order;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Contracts;

public interface ITicketService
{
    Task<DateTimeOffset> ReserveTicketsAsync(Guid userId, List<ReservedTicketEntity> reserveTickets);
    Task<List<ReservedTicketEntity>> GetUserReservedTicketsAsync(Guid userId);
}
