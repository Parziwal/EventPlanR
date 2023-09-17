using EventPlanr.Domain.Enums;

namespace EventPlanr.Application.Models.Ticket;

public class AddReserveTicketDto
{
    public Guid TicketId { get; set; }
    public int Count { get; set; }
}
