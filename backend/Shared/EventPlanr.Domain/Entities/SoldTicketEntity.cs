using EventPlanr.Domain.Common;

namespace EventPlanr.Domain.Entities;

public class SoldTicketEntity : BaseEntity
{
    public string UserFirstName { get; set; } = null!;
    public string UserLastName { get; set; } = null!;
    public double Price { get; set; }
    public Guid TicketId { get; set; }
    public TicketEntity Ticket { get; set; } = null!;
    public Guid OrderId { get; set; }
    public OrderEntity Order { get; set; } = null!;
    public bool IsRefunded { get; set; }
    public bool IsCheckedIn { get; set; }
    public DateTimeOffset? CheckInDate { get; set; }
}
