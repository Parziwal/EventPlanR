using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Common;
using EventPlanr.Application.Models.Order;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Common;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Repository;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Order.Commands;

[Authorize]
public class OrderReservedTicketsCommand : IRequest<Guid>
{
    public string CustomerFirstName { get; set; } = null!;
    public string CustomerLastName { get; set; } = null!;
    public AddressDto BillingAddress { get; set; } = null!;
    public List<AddTicketUserInfoDto> TicketUserInfos { get; set; } = new List<AddTicketUserInfoDto>();
}

public class OrderReservedTicketsCommandHandler : IRequestHandler<OrderReservedTicketsCommand, Guid>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly ITicketOrderService _ticketService;
    private readonly IUserContext _user;
    private readonly ITimeRepository _timeRepository;

    public OrderReservedTicketsCommandHandler(
        IApplicationDbContext dbContext,
        ITicketOrderService ticketService,
        IUserContext user,
        ITimeRepository timeRepository)
    {
        _dbContext = dbContext;
        _ticketService = ticketService;
        _user = user;
        _timeRepository = timeRepository;
    }

    public async Task<Guid> Handle(OrderReservedTicketsCommand request, CancellationToken cancellationToken)
    {
        var reservedTickets = await _ticketService.GetUserReservedTicketsAsync(_user.UserId);

        foreach (var reservedTicket in reservedTickets)
        {
            var ticketInfoCount = request.TicketUserInfos
                .Where(tui => tui.TicketId == reservedTicket.TicketId)
                .Count();
            if (ticketInfoCount != reservedTicket.Count)
            {
                throw new DomainException("TicketUserInfoCountNotMatchWithReservedTicketCount");
            }
        }

        var order = new OrderEntity()
        {
            CustomerUserId = _user.UserId,
            CustomerFirstName = request.CustomerFirstName,
            CustomerLastName = request.CustomerLastName,
            BillingAddress = new Address()
            {
                Country = request.BillingAddress.Country,
                ZipCode = request.BillingAddress.ZipCode,
                City = request.BillingAddress.City,
                AddressLine = request.BillingAddress.AddressLine,
            },
            Total = reservedTickets.Sum(rt => rt.Price * rt.Count),
            Currency = reservedTickets.First().Currency,
            SoldTickets = request.TicketUserInfos.Select(tui => new SoldTicketEntity()
            {
                UserFirstName = tui.UserFirstName,
                UserLastName = tui.UserLastName,
                TicketId = tui.TicketId,
                Price = reservedTickets.Single(rt => rt.TicketId == tui.TicketId).Price,
            }).ToList(),
        };

        _dbContext.Orders.Add(order);

        var ticketIds = reservedTickets.Select(rt => rt.TicketId).ToList();
        var events = await _dbContext.Events
            .Include(e => e.Chat)
                .ThenInclude(c => c.ChatMembers)
            .Where(e => e.Tickets.Any(t => ticketIds.Contains(t.Id)))
            .Where(e => e.Chat.ChatMembers.All(c => c.MemberUserId != _user.UserId))
            .ToListAsync();

        events.ForEach(e =>
        {
            if (e.Chat.ChatMembers.All(cm => cm.MemberUserId != _user.UserId))
            {
                e.Chat.ChatMembers.Add(new ChatMemberEntity()
                {
                    LastSeen = _timeRepository.GetCurrentUtcTime(),
                    MemberUserId = _user.UserId
                });
            }
        });

        await _dbContext.SaveChangesAsync();

        return order.Id;
    }
}