using EventPlanr.Domain.Enums;

namespace EventPlanr.Application.Models.Order;

public class StoreReservedTicketDto
{
    public Guid TicketId { get; set; }
    public int Count { get; set; }
    public double Price { get; set; }
    public Currency Currency { get; set; }
}
