using EventPlanr.Domain.Common;

namespace EventPlanr.Domain.Entities;

public class SoldTicket : BaseEntity
{
    public string UserFirstName { get; set; } = null!;
    public string UserLastName { get; set; } = null!;
    public double Price { get; set; }
    public Guid TicketId { get; set; }
    public Ticket Ticket { get; set; } = null!;
    public Guid OrderId { get; set; }
    public Order Order { get; set; } = null!;
}
