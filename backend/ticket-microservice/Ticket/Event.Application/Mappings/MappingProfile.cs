using AutoMapper;
using Ticket.Application.Dto;
using Ticket.Domain.Entities;

namespace Ticket.Application.Mappings;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<EventTicket, EventTicketDto>();
        CreateMap<SoldTicket, UserTicketDto>();
    }
}
