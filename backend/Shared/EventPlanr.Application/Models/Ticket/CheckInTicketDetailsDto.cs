using AutoMapper;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Application.Models.Ticket;

public class CheckInTicketDetailsDto
{
    public Guid Id { get; set; }
    public string UserFirstName { get; set; } = null!;
    public string UserLastName { get; set; } = null!;
    public string TicketName { get; set; } = null!;
    public bool IsCheckedIn { get; set; }
    public double Price { get; set; }
    public Currency Currency { get; set; }
    public Guid OrderId { get; set; }
    public DateTimeOffset Created { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<SoldTicketEntity, CheckInTicketDetailsDto>()
                .ForMember(dest => dest.TicketName, opt => opt.MapFrom(src => src.Ticket.Name))
                .ForMember(dest => dest.Currency, opt => opt.MapFrom(src => src.Order.Currency))
                .ForMember(dest => dest.Created, opt => opt.MapFrom(src => src.Order.Created));
        }
    }
}
