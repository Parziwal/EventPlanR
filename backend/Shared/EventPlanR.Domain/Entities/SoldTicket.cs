using EventPlanr.Domain.Common;

namespace EventPlanr.Domain.Entities;

public class SoldTicket : BaseEntity
{
    public string UserFirstName { get; set; } = null!;
    public string UserLastName { get; set; } = null!;
    public Guid TickerId { get; set; }
    public Ticket Ticket { get; set; } = null!;
}
