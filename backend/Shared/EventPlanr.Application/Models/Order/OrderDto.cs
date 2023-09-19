using AutoMapper;
using EventPlanr.Application.Models.Common;
using EventPlanr.Application.Models.Ticket;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Application.Models.Order;

public class OrderDto
{
    public string CustomerFirstName { get; set; } = null!;
    public string CustomerLastName { get; set; } = null!;
    public AddressDto BillingAddress { get; set; } = null!;
    public double Total { get; set; }
    public Currency Currency { get; set; }
    public List<SoldTicketDto> SoldTickets { get; set; } = new List<SoldTicketDto>();

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<OrderEntity, OrderDto>();
        }
    }
}
