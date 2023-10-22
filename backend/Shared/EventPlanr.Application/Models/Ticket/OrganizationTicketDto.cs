using AutoMapper;
using EventPlanr.Application.Models.Common;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.Ticket;

public class OrganizationTicketDto : BaseAuditableDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = null!;
    public int Count { get; set; }
    public int RemainingCount { get; set; }
    public double Price { get; set; }
    public string? Description { get; set; }
    public DateTimeOffset SaleStarts { get; set; }
    public DateTimeOffset SalesEnds { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<TicketEntity, OrganizationTicketDto>();
        }
    }
}
