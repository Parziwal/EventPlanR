using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Invitation.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.InvitationManage)]
public class DeleteInvitationCommand : IRequest
{
    public Guid InvitationId { get; set; }
}

public class DeleteInvitationCommandHandler : IRequestHandler<DeleteInvitationCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    public DeleteInvitationCommandHandler(
        IApplicationDbContext dbContext,
        IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task Handle(DeleteInvitationCommand request, CancellationToken cancellationToken)
    {
        var invitation = await _dbContext.Invitations
            .SingleEntityAsync(i => i.Id == request.InvitationId && i.Event.OrganizationId == _user.OrganizationId);

        var invitationOrder = await _dbContext.Orders
            .SingleOrDefaultAsync(st => st.CustomerUserId == invitation.UserId &&
                st.SoldTickets.First().TicketId == st.SoldTickets.First().Ticket.Event.InvitationTicketId);

        if (invitationOrder != null)
        {
            _dbContext.Orders.Remove(invitationOrder);
        }

        await _dbContext.SaveChangesAsync();
    }
}
