using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Ticket.Commands;

public class UpdateTicketCommand : IRequest
{
    public Guid TicketId { get; set; }
    public double Price { get; set; }
    public int Count { get; set; }
    public string? Description { get; set; }
    public DateTimeOffset SaleStarts { get; set; }
    public DateTimeOffset SaleEnds { get; set; }
}

public class UpdateTicketCommandHandler : IRequestHandler<UpdateTicketCommand>
{
    private readonly IApplicationDbContext _context;
    private readonly IUserContext _user;

    public UpdateTicketCommandHandler(IApplicationDbContext context, IUserContext user)
    {
        _context = context;
        _user = user;
    }

    public async Task Handle(UpdateTicketCommand request, CancellationToken cancellationToken)
    {
        var ticket = await _context.Tickets
            .Include(t => t.Event)
            .Include(t => t.SoldTickets)
            .SingleEntityAsync(t => t.Id == request.TicketId);

        if (!_user.OrganizationIds.Contains(ticket.Event.OrganizationId.ToString()))
        {
            throw new UserNotBelongToOrganizationException(_user.UserId, ticket.Event.OrganizationId.ToString());
        }

        if (ticket.Event.FromDate > request.SaleStarts || ticket.Event.ToDate < request.SaleStarts
            || ticket.Event.FromDate > request.SaleEnds || ticket.Event.ToDate < request.SaleEnds)
        {
            throw new TicketSaleDatesNotBetweenEventDateException(request.SaleStarts, request.SaleEnds, ticket.Event.FromDate, ticket.Event.ToDate);
        }

        ticket.Price = request.Price;
        ticket.Count = request.Count;
        ticket.Description = request.Description;
        ticket.SaleStarts = request.SaleStarts;
        ticket.SaleEnds = request.SaleEnds;

        var calculatedTicketCount = ticket.Count - ticket.SoldTickets.Count();
        ticket.RemainingCount = calculatedTicketCount > 0 ? calculatedTicketCount : 0;

        await _context.SaveChangesAsync();
    }
}