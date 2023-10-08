using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Domain.Entities;
using MediatR;
using System.Text.Json.Serialization;

namespace EventPlanr.Application.Features.Ticket.Commands;

public class AddTicketToEventCommand : IRequest<Guid>
{
    [JsonIgnore]
    public Guid EventId { get; set; }
    public string Name { get; set; } = null!;
    public double Price { get; set; }
    public int Count { get; set; }
    public string? Description { get; set; }
    public DateTimeOffset SaleStarts { get; set; }
    public DateTimeOffset SaleEnds { get; set; }
}

public class AddTicketToEventCommandHandler : IRequestHandler<AddTicketToEventCommand, Guid>
{
    private readonly IApplicationDbContext _context;
    private readonly IUserContext _user;

    public AddTicketToEventCommandHandler(IApplicationDbContext context, IUserContext user)
    {
        _context = context;
        _user = user;
    }

    public async Task<Guid> Handle(AddTicketToEventCommand request, CancellationToken cancellationToken)
    {
        var eventEntity = await _context.Events
            .SingleEntityAsync(e => e.Id == request.EventId);

        //if (!_user.OrganizationIds.Contains(eventEntity.OrganizationId))
        //{
            //throw new UserNotBelongToOrganizationException(_user.UserId, eventEntity.OrganizationId.ToString());
        //}

        if (eventEntity.FromDate > request.SaleStarts || eventEntity.ToDate < request.SaleStarts
            || eventEntity.FromDate > request.SaleEnds || eventEntity.ToDate < request.SaleEnds)
        {
            throw new TicketSaleDatesNotBetweenEventDateException(request.SaleStarts, request.SaleEnds, eventEntity.FromDate, eventEntity.ToDate);
        }

        var ticket = new TicketEntity()
        {
            Name = request.Name,
            Price = request.Price,
            Count = request.Count,
            RemainingCount = request.Count,
            Description = request.Description,
            SaleStarts = request.SaleStarts,
            SaleEnds = request.SaleEnds,
            Event = eventEntity,
        };

        _context.Tickets.Add(ticket);
        await _context.SaveChangesAsync();

        return ticket.Id;
    }
}
