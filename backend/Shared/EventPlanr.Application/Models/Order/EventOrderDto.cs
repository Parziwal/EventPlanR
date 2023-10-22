using AutoMapper;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Application.Models.Order;

public class EventOrderDto
{
    public Guid Id { get; set; }
    public string CustomerFirstName { get; set; } = null!;
    public string CustomerLastName { get; set; } = null!;
    public double Total { get; set; }
    public Currency Currency { get; set; }
    public int TicketCount { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<OrderEntity, EventOrderDto>()
                .ForMember(dest => dest.TicketCount, opt => opt.MapFrom(src => src.SoldTickets.Count()));
        }
    }
}
