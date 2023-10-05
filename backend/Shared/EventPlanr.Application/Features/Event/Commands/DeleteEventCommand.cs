using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Event.Commands;

public class DeleteEventCommand : IRequest
{
    public Guid EventId { get; set; }
}

public class DeleteEventCommandHandler : IRequestHandler<DeleteEventCommand>
{
    private readonly IApplicationDbContext _context;
    private readonly IUserContext _user;

    public DeleteEventCommandHandler(IApplicationDbContext context, IUserContext user)
    {
        _context = context;
        _user = user;
    }

    public async Task Handle(DeleteEventCommand request, CancellationToken cancellationToken)
    {
        var eventEntity = await _context.Events
            .Include(e => e.Tickets)
                .ThenInclude(t => t.SoldTickets)
            .Include(e => e.NewsPosts)
            .Include(e => e.Invitations)
            .SingleEntityAsync(e => e.Id == request.EventId);

        if (!_user.OrganizationIds.Contains(eventEntity.OrganizationId))
        {
            //throw new UserNotBelongToOrganizationException(_user.UserId, eventEntity.OrganizationId.ToString());
        }

        if (eventEntity.Tickets.Sum(t => t.SoldTickets.Count()) > 0)
        {
            throw new EventCanNotBeDeletedException(eventEntity.Id);
        }

        _context.Tickets.RemoveRange(eventEntity.Tickets);
        _context.Events.Remove(eventEntity);

        await _context.SaveChangesAsync();
    }
}
