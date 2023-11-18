using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Invitation.Commands;

[Authorize]
public class AcceptOrDenyInvitationCommand : IRequest
{
    public Guid InvitationId { get; set; }
    public bool Accept { get; set; }
}

public class AcceptOrDenyInvitationCommandHandler : IRequestHandler<AcceptOrDenyInvitationCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public AcceptOrDenyInvitationCommandHandler(
        IApplicationDbContext dbContext,
        IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task Handle(AcceptOrDenyInvitationCommand request, CancellationToken cancellationToken)
    {
        var invitation = await _dbContext.Invitations
            .Include(i => i.Event)
            .SingleEntityAsync(i => i.Id == request.InvitationId && i.UserEmail == _user.Email);

        if (invitation.Event.ToDate < DateTimeOffset.UtcNow)
        {
            throw new DomainException();
        }

        invitation.UserId = _user.UserId;
        invitation.Status = request.Accept ? InvitationStatus.Accept : InvitationStatus.Deny;

        await _dbContext.SaveChangesAsync();
    }
}
