using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Common;
using EventPlanr.Application.Models.Order;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Common;
using EventPlanr.Domain.Entities;
using MediatR;

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
    private readonly IApplicationDbContext _context;
    private readonly ITicketOrderService _ticketService;
    private readonly IUserContext _user;

    public OrderReservedTicketsCommandHandler(IApplicationDbContext context, ITicketOrderService ticketService, IUserContext user)
    {
        _context = context;
        _ticketService = ticketService;
        _user = user;
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
                throw new DomainException("TicketUserInfoNotMatchException");
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

        _context.Orders.Add(order);
        await _context.SaveChangesAsync();

        return order.Id;
    }
}