using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Organization.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationManage)]
public class DeleteUserOrganizationCommand : IRequest
{
}

public class DeleteUserOrganizationCommandHandler : IRequestHandler<DeleteUserOrganizationCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IUserClaimService _userClaimService;

    public DeleteUserOrganizationCommandHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IUserClaimService userClaimService)
    {
        _dbContext = dbContext;
        _user = user;
        _userClaimService = userClaimService;
    }

    public async Task Handle(DeleteUserOrganizationCommand request, CancellationToken cancellationToken)
    {
        var organization = await _dbContext.Organizations
            .SingleEntityAsync(o => o.Id == _user.OrganizationId);

        if (organization.Events.Any(e => e.IsPublished && e.ToDate >= DateTimeOffset.Now))
        {
            throw new DomainException("OrganizationWithUpcomingEventCannotBeDeletedException");
        }

        var deletableEvents = await _dbContext.Events
            .Include(e => e.Tickets)
            .Include(e => e.NewsPosts)
            .Include(e => e.Invitations)
            .Where(e => e.OrganizationId == organization.Id && !e.IsPublished)
            .ToListAsync();

        _dbContext.Events.RemoveRange(deletableEvents);
        _dbContext.Organizations.Remove(organization);

        await _dbContext.SaveChangesAsync();

        foreach (var member in organization.MemberUserIds)
        {
            await _userClaimService.RemoveOrganizationFromUserAsync(member, organization.Id);
        }
    }
}
