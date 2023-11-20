using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Event.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationEventManage)]
public class UnPublishEventCommand : IRequest
{
    public Guid EventId { get; set; }
}

public class UnPublishEventCommandHandler : IRequestHandler<UnPublishEventCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public UnPublishEventCommandHandler(IApplicationDbContext dbContext, IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task Handle(UnPublishEventCommand request, CancellationToken cancellationToken)
    {
        var eventEntity = await _dbContext.Events
            .Include(e => e.Tickets)
                .ThenInclude(t => t.SoldTickets)
            .SingleEntityAsync(e => e.Id == request.EventId && e.OrganizationId == _user.OrganizationId);

        if (eventEntity.Tickets.Any(t => t.Count != t.RemainingCount))
        {
            throw new DomainException("EventWithUnrefundedOrdersCannotBeDeleted");
        }

        if (eventEntity.ToDate < DateTime.UtcNow)
        {
            throw new DomainException("PastEventCannotBePublished");
        }

        eventEntity.IsPublished = false;

        await _dbContext.SaveChangesAsync();
    }
}
