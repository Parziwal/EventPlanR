using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Event.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationEventManage)]
public class PublishEventCommand : IRequest
{
    public Guid EventId { get; set; }
}

public class PublishEventCommandHandler : IRequestHandler<PublishEventCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public PublishEventCommandHandler(IApplicationDbContext dbContext, IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task Handle(PublishEventCommand request, CancellationToken cancellationToken)
    {
        var eventEntity = await _dbContext.Events
            .Include(e => e.Tickets)
            .SingleEntityAsync(e => e.Id == request.EventId && e.OrganizationId == _user.OrganizationId);

        if (eventEntity.IsPrivate)
        {
            throw new DomainException("PrivateEventCannotBePublished");
        }

        if (eventEntity.Tickets.Count() == 0)
        {
            throw new DomainException("PublicEventWithoutTicketsCannotBePublished");
        }

        if (eventEntity.FromDate < DateTime.UtcNow)
        {
            throw new DomainException("PastEventCannotBePublished");
        }

        eventEntity.IsPublished = true;

        await _dbContext.SaveChangesAsync();
    }
}
