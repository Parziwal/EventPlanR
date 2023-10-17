using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;

namespace EventPlanr.Application.Features.Organization.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationManage)]
public class RemoveMemberFromOrganizationCommand : IRequest
{
    public Guid MemberUserId { get; set; }
}

public class RemoveMemberFromOrganizationCommandHandler : IRequestHandler<RemoveMemberFromOrganizationCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IUserClaimService _userClaimService;

    public RemoveMemberFromOrganizationCommandHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IUserClaimService userClaimService)
    {
        _dbContext = dbContext;
        _user = user;
        _userClaimService = userClaimService;
    }

    public async Task Handle(RemoveMemberFromOrganizationCommand request, CancellationToken cancellationToken)
    {
        var organization = await _dbContext.Organizations
            .SingleEntityAsync(o => o.Id == _user.OrganizationId);
        organization.MemberUserIds.Remove(request.MemberUserId);
        await _dbContext.SaveChangesAsync();

        await _userClaimService.RemoveOrganizationFromUserAsync(request.MemberUserId, organization.Id);
    }
}
