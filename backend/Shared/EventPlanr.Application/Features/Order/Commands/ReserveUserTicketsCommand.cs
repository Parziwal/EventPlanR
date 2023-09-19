using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Order;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Order.Commands;

public class ReserveUserTicketsCommand : IRequest
{
    public List<AddReserveTicketDto> ReserveTickets { get; set; } = new List<AddReserveTicketDto>();
}

public class ReserveUserTicketsCommandHandler : IRequestHandler<ReserveUserTicketsCommand>
{
    private readonly IApplicationDbContext _context;
    private readonly ITicketService _ticketService;
    private readonly IUserContext _user;

    public ReserveUserTicketsCommandHandler(IApplicationDbContext context, ITicketService ticketService, IUserContext user)
    {
        _context = context;
        _ticketService = ticketService;
        _user = user;
    }

    public async Task Handle(ReserveUserTicketsCommand request, CancellationToken cancellationToken)
    {
        var storeTicket = new List<StoreReservedTicketDto>();
        foreach (var reserveTicket in request.ReserveTickets)
        {
            var ticket = await _context.Tickets
                .Include(t => t.Event)
                .SingleEntityAsync(t => t.Id == reserveTicket.TicketId, reserveTicket.TicketId);
            if (ticket.SaleStarts <= DateTimeOffset.Now && ticket.SaleEnds >= DateTimeOffset.Now)
            {
                throw new TicketNotOnSaleException(ticket);
            }

            if (ticket.RemainingCount < reserveTicket.Count)
            {
                throw new NotEnoughTicketException(ticket);
            }

            ticket.RemainingCount -= reserveTicket.Count;
            storeTicket.Add(new StoreReservedTicketDto()
            {
                TicketId = ticket.Id,
                Count = reserveTicket.Count,
                Price = ticket.Price,
                Currency = ticket.Event.Currency,
            });
        }

        await _context.SaveChangesAsync();
        await _ticketService.StoreReservedTicketsAsync(_user.UserId, storeTicket);
    }
}
