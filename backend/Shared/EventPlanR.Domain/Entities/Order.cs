﻿using EventPlanr.Domain.Common;

namespace EventPlanr.Domain.Entities;

public class Order : BaseAuditableEntity
{
    public string CustomerUserId { get; set; } = null!;
    public string CustomerFirstName { get; set; } = null!;
    public string CustomerLastName { get; set; } = null!;
    public Address BillingAddress { get; set; } = null!;
    public List<SoldTicket> SoldTickets { get; set; } = new List<SoldTicket>();
}
