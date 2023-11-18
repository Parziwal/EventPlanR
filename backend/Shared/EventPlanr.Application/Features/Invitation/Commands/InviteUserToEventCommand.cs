using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Invitation.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.InvitationManage)]
public class InviteUserToEventCommand : IRequest
{
    public Guid EventId { get; set; }
    public string UserEmail { get; set; } = null!;
}

public class InviteUserToEventCommandHandler : IRequestHandler<InviteUserToEventCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IUserService _userService;

    public InviteUserToEventCommandHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IUserService userService)
    {
        _dbContext = dbContext;
        _user = user;
        _userService = userService;
    }

    public async Task Handle(InviteUserToEventCommand request, CancellationToken cancellationToken)
    {
        var eventEntity = await _dbContext.Events
            .Include(e => e.Invitations)
            .SingleEntityAsync(e => e.Id == request.EventId && e.OrganizationId == _user.OrganizationId);

        if (eventEntity.Invitations.Any(i => i.UserEmail == request.UserEmail))
        {
            throw new DomainException();
        }

        var userId = await _userService.GetUserIdByEmail(request.UserEmail);

        var invitation = new InvitationEntity()
        { 
            UserId = userId,
            UserEmail = request.UserEmail,
            Event = eventEntity,
            Status = InvitationStatus.Pending,
        };

        _dbContext.Invitations.Add(invitation);

        await _dbContext.SaveChangesAsync(); 
    }
}