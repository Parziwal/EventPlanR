using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Invitation;
using EventPlanr.Application.Security;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Invitation.Queries;

[Authorize]
public class GetUserEventInvitationQuery : IRequest<UserInvitationDto>
{
    public Guid EventId { get; set; }
}

public class GetUserEventInvitationQueryHandler : IRequestHandler<GetUserEventInvitationQuery, UserInvitationDto>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IMapper _mapper;

    public GetUserEventInvitationQueryHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IMapper mapper)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
    }

    public async Task<UserInvitationDto> Handle(GetUserEventInvitationQuery request, CancellationToken cancellationToken)
    {
        var invitation = await _dbContext.Invitations
            .Include(i => i.Event)
            .Include(i => i.Event.Organization)
            .SingleEntityAsync(i => i.EventId == request.EventId && i.UserId == _user.UserId);

        var invitationTicket = await _dbContext.SoldTickets
            .SingleOrDefaultAsync(st => st.TicketId == st.Ticket.Event.InvitationTicketId && st.Order.CustomerUserId == _user.UserId);

        var mappedInvitation = _mapper.Map<UserInvitationDto>(invitation);
        mappedInvitation.TicketId = invitationTicket?.Id;

        return mappedInvitation;
    }
}
