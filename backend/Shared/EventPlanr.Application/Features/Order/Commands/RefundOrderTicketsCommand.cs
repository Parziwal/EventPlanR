using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Order.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.EventTicketManage)]
public class RefundOrderTicketsCommand : IRequest
{
    public Guid OrderId { get; set; }
}

public class RefundOrderCommandHandler : IRequestHandler<RefundOrderTicketsCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public RefundOrderCommandHandler(IApplicationDbContext dbContext, IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task Handle(RefundOrderTicketsCommand request, CancellationToken cancellationToken)
    {
        var order = await _dbContext.Orders
            .Include(o => o.SoldTickets)
                .ThenInclude(st => st.Ticket)
                    .ThenInclude(t => t.Event)
            .SingleEntityAsync(o => o.Id == request.OrderId);

        if (order.CustomerUserId != _user.UserId
            && (order.SoldTickets.First().Ticket.Event.OrganizationId != _user.OrganizationId
            || !_user.OrganizationPolicies.Contains(OrganizationPolicies.EventTicketManage)))
        {
            throw new ForbiddenException("User don't have permission");
        }

        foreach (var soldTicket in order.SoldTickets)
        {
            soldTicket.IsRefunded = false;
            soldTicket.Ticket.RemainingCount++;
        }

        await _dbContext.SaveChangesAsync();
    }
}
