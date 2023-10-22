using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Order;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Order.Commands;

[Authorize]
public class ReserveUserTicketsCommand : IRequest<DateTimeOffset>
{
    public List<AddReserveTicketDto> ReserveTickets { get; set; } = new List<AddReserveTicketDto>();
}

public class ReserveUserTicketsCommandHandler : IRequestHandler<ReserveUserTicketsCommand, DateTimeOffset>
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

    public async Task<DateTimeOffset> Handle(ReserveUserTicketsCommand request, CancellationToken cancellationToken)
    {
        var storeTicket = new List<ReservedTicketEntity>();
        foreach (var reserveTicket in request.ReserveTickets)
        {
            var ticket = await _context.Tickets
                .Include(t => t.Event)
                .SingleEntityAsync(t => t.Id == reserveTicket.TicketId);
            if (ticket.SaleStarts <= DateTimeOffset.Now && ticket.SaleEnds >= DateTimeOffset.Now)
            {
                throw new DomainException("TicketNotOnSaleException");
            }

            if (ticket.RemainingCount < reserveTicket.Count)
            {
                throw new DomainException("NotEnoughTicketException");
            }

            ticket.RemainingCount -= reserveTicket.Count;
            storeTicket.Add(new ReservedTicketEntity()
            {
                TicketId = ticket.Id,
                Count = reserveTicket.Count,
                Price = ticket.Price,
                Currency = ticket.Event.Currency,
            });
        }

        var resarvationTime = await _ticketService.ReserveTicketsAsync(_user.UserId, storeTicket);
        await _context.SaveChangesAsync();

        return resarvationTime;
    }
}
