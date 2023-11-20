using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Ticket.Commands;

[Authorize]
public class RefundTicketCommand : IRequest
{
    public Guid SoldTicketId { get; set; }
}

public class RefundTicketCommandHandler : IRequestHandler<RefundTicketCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public RefundTicketCommandHandler(IApplicationDbContext dbContext, IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task Handle(RefundTicketCommand request, CancellationToken cancellationToken)
    {
        var ticket = await _dbContext.SoldTickets
            .Include(st => st.Order)
            .Include(st => st.Ticket)
                .ThenInclude(t => t.Event)
            .SingleEntityAsync(st => st.Id == request.SoldTicketId);

        if (ticket.Order.CustomerUserId != _user.UserId
            && (ticket.Ticket.Event.OrganizationId != _user.OrganizationId
            || !_user.OrganizationPolicies.Contains(OrganizationPolicies.EventTicketManage)))
        {
            throw new ForbiddenException();
        }

        ticket.IsRefunded = true;
        ticket.Ticket.RemainingCount++;

        await _dbContext.SaveChangesAsync();
    }
}
