using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Ticket.Commands;

public class DeleteTicketCommand : IRequest
{
    public Guid TicketId { get; set; }
}

public class DeleteTicketCommandHandler : IRequestHandler<DeleteTicketCommand>
{
    private readonly IApplicationDbContext _context;

    public DeleteTicketCommandHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task Handle(DeleteTicketCommand request, CancellationToken cancellationToken)
    {
        var ticket = await _context.Tickets
            .Include(t => t.SoldTickets)
            .SingleEntityAsync(t => t.Id == request.TicketId);

        if (ticket.SoldTickets.Count() > 0)
        {
            throw new TicketCanNotBeDeletedException(ticket.Id);
        }

        _context.Tickets.Remove(ticket);
        await _context.SaveChangesAsync();
    }
}
