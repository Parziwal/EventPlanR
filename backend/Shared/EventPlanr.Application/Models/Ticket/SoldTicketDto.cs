using AutoMapper;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Application.Models.Ticket;

public class SoldTicketDto
{
    public Guid Id { get; set; }
    public string UserFirstName { get; set; } = null!;
    public string UserLastName { get; set; } = null!;
    public double Price { get; set; }
    public Currency Currency { get; set; }
    public string TicketName { get; set; } = null!;

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<SoldTicketEntity, SoldTicketDto>()
                .ForMember(dest => dest.TicketName, opt => opt.MapFrom(src => src.Ticket.Name))
                .ForMember(dest => dest.Currency, opt => opt.MapFrom(src => src.Order.Currency));
        }
    }
}
