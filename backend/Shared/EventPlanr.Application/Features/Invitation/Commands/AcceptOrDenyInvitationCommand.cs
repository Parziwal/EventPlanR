using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Common;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Enums;
using EventPlanr.Domain.Repository;
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
    private readonly IUserService _userService;
    private readonly ITimeRepository _timeRepository;

    public AcceptOrDenyInvitationCommandHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IUserService userService,
        ITimeRepository timeRepository)
    {
        _dbContext = dbContext;
        _user = user;
        _userService = userService;
        _timeRepository = timeRepository;
    }

    public async Task Handle(AcceptOrDenyInvitationCommand request, CancellationToken cancellationToken)
    {
        var invitation = await _dbContext.Invitations
            .Include(i => i.Event)
                .ThenInclude(e => e.Chat)
            .SingleEntityAsync(i => i.Id == request.InvitationId && i.UserId == _user.UserId);

        var timeNow = _timeRepository.GetCurrentUtcTime();
        if (invitation.Event.ToDate < timeNow)
        {
            throw new DomainException("PastEventInvitationStatusCannotBeChanged");
        }

        if (invitation.Status != InvitationStatus.Pending)
        {
            throw new DomainException("AcceptedOrDeniedInvitationStatusCannotBeChanged");
        }

        invitation.UserId = _user.UserId;
        invitation.Status = request.Accept ? InvitationStatus.Accept : InvitationStatus.Deny;

        if (request.Accept)
        {
            var user = await _userService.GetUserById(_user.UserId)
                ?? throw new EntityNotFoundException("UserEntity_NotFound");
            var order = new OrderEntity()
            {
                CustomerUserId = user.Id,
                CustomerFirstName = user.FirstName,
                CustomerLastName = user.LastName,
                BillingAddress = new Address
                {
                    City = "-",
                    ZipCode = "-",
                    Country = "-",
                    AddressLine = "-",
                },
            };

            var ticket = new SoldTicketEntity()
            {
                UserFirstName = user.FirstName,
                UserLastName = user.LastName,
                TicketId = invitation.Event.InvitationTicketId,
                Order = order,
            };

            _dbContext.SoldTickets.Add(ticket);

            var chatMember = new ChatMemberEntity()
            {
                ChatId = invitation.Event.ChatId,
                LastSeen = timeNow,
                MemberUserId = _user.UserId
            };

            _dbContext.ChatMembers.Add(chatMember);
        }

        await _dbContext.SaveChangesAsync();
    }
}
