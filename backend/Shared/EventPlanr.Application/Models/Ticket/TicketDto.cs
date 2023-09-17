using AutoMapper;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.Ticket;

public class TicketDto
{
    public string Name { get; set; } = null!;
    public double Price { get; set; }
    public int Count { get; set; }
    public string? Description { get; set; }
    public DateTimeOffset SaleStarts { get; set; }
    public DateTimeOffset SalesEnds { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<TicketEntity, TicketDto>();
        }
    }
}
