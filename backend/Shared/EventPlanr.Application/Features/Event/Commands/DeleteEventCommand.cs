using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions.Event;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Event.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationEventManage)]
public class DeleteEventCommand : IRequest
{
    public Guid EventId { get; set; }
}

public class DeleteEventCommandHandler : IRequestHandler<DeleteEventCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public DeleteEventCommandHandler(IApplicationDbContext dbContext, IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task Handle(DeleteEventCommand request, CancellationToken cancellationToken)
    {
        var eventEntity = await _dbContext.Events
            .Include(e => e.Tickets)
            .Include(e => e.NewsPosts)
            .Include(e => e.Invitations)
            .SingleEntityAsync(e => e.Id == request.EventId && e.OrganizationId == _user.OrganizationId);

        if (eventEntity.IsPublished)
        {
            throw new PublishedEventCannotBeDeletedException();
        }

        _dbContext.Events.Remove(eventEntity);

        await _dbContext.SaveChangesAsync();
    }
}
