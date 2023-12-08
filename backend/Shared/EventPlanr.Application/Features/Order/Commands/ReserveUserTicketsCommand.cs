using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Order;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Repository;
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
    private readonly ITicketOrderService _ticketService;
    private readonly IUserContext _user;
    private readonly ITimeRepository _timeRepository;

    public ReserveUserTicketsCommandHandler(
        IApplicationDbContext context,
        ITicketOrderService ticketService,
        IUserContext user,
        ITimeRepository timeRepository)
    {
        _context = context;
        _ticketService = ticketService;
        _user = user;
        _timeRepository = timeRepository;
    }

    public async Task<DateTimeOffset> Handle(ReserveUserTicketsCommand request, CancellationToken cancellationToken)
    {
        var reservedTickets = new List<ReservedTicketEntity>();
        foreach (var reserveTicket in request.ReserveTickets)
        {
            var ticket = await _context.Tickets
                .Include(t => t.Event)
                .SingleEntityAsync(t => t.Id == reserveTicket.TicketId && t.Event.IsPublished && !t.Event.IsPrivate);

            var timeNow = _timeRepository.GetCurrentUtcTime();
            if (ticket.SaleStarts > timeNow || ticket.SaleEnds < timeNow)
            {
                throw new DomainException("TicketNotOnSale");
            }

            if (ticket.RemainingCount < reserveTicket.Count)
            {
                throw new DomainException("NotEnoughTicket");
            }

            ticket.RemainingCount -= reserveTicket.Count;
            reservedTickets.Add(new ReservedTicketEntity()
            {
                TicketId = ticket.Id,
                Count = reserveTicket.Count,
                Price = ticket.Price,
                Currency = ticket.Event.Currency,
            });
        }

        var expirationTime = await _ticketService.ReserveTicketsAsync(_user.UserId, reservedTickets);
        await _context.SaveChangesAsync();

        return expirationTime;
    }
}
