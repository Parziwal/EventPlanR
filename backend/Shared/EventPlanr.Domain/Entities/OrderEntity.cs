using EventPlanr.Domain.Common;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Domain.Entities;

public class OrderEntity : BaseAuditableEntity
{
    public string CustomerUserId { get; set; } = null!;
    public string CustomerFirstName { get; set; } = null!;
    public string CustomerLastName { get; set; } = null!;
    public Address BillingAddress { get; set; } = null!;
    public double Total { get; set; }
    public Currency Currency { get; set; }
    public List<SoldTicketEntity> SoldTickets { get; set; } = new List<SoldTicketEntity>();
}
