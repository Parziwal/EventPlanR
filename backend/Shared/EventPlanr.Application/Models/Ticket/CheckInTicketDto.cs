using AutoMapper;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.Ticket;

public class CheckInTicketDto
{
    public Guid Id { get; set; }
    public string UserFirstName { get; set; } = null!;
    public string UserLastName { get; set; } = null!;
    public string TicketName { get; set; } = null!;
    public bool IsCheckedIn { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<SoldTicketEntity, CheckInTicketDto>()
                .ForMember(dest => dest.TicketName, opt => opt.MapFrom(src => src.Ticket.Name));
        }
    }
}
