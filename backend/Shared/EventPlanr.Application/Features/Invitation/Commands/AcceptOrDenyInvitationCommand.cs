using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Common;
using EventPlanr.Domain.Entities;
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
    private readonly IUserService _userService;

    public AcceptOrDenyInvitationCommandHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IUserService userService)
    {
        _dbContext = dbContext;
        _user = user;
        _userService = userService;
    }

    public async Task Handle(AcceptOrDenyInvitationCommand request, CancellationToken cancellationToken)
    {
        var invitation = await _dbContext.Invitations
            .Include(i => i.Event)
                .ThenInclude(e => e.Chat)
            .SingleEntityAsync(i => i.Id == request.InvitationId && i.UserId == _user.UserId);

        if (invitation.Event.ToDate < DateTimeOffset.UtcNow)
        {
            throw new DomainException("PastEventInvitationStatusCannotBeChanged");
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
                LastSeen = DateTimeOffset.UtcNow,
                MemberUserId = _user.UserId
            };

            _dbContext.ChatMembers.Add(chatMember);
        }
        else
        {
            var invitationOrder = await _dbContext.Orders
                .SingleOrDefaultAsync(st => st.CustomerUserId == invitation.UserId &&
                    st.SoldTickets.First().TicketId == st.SoldTickets.First().Ticket.Event.InvitationTicketId);

            if (invitationOrder != null)
            {
                _dbContext.Orders.Remove(invitationOrder);
            }

            var chatMember = invitation.Event.Chat.ChatMembers
                .SingleOrDefault(cm => cm.MemberUserId == _user.UserId);

            if (chatMember != null)
            {
                _dbContext.ChatMembers.Remove(chatMember);
            }
        }

        await _dbContext.SaveChangesAsync();
    }
}
