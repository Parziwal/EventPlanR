using AutoMapper;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Enums;

namespace EventPlanr.Application.Models.Ticket;

public class TicketDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = null!;
    public double Price { get; set; }
    public Currency Currency { get; set; }
    public int Count { get; set; }
    public string? Description { get; set; }
    public DateTimeOffset SaleStarts { get; set; }
    public DateTimeOffset SaleEnds { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<TicketEntity, TicketDto>()
                .ForMember(dest => dest.Currency, opt => opt.MapFrom(src => src.Event.Currency));
        }
    }
}
