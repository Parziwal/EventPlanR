using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions.Organization;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using MediatR;

namespace EventPlanr.Application.Features.Organization.Commands;

[Authorize]
public class SetUserOrganizationCommand : IRequest
{
    public Guid OrganizationId { get; set; }
}

public class SetUserOrganizationCommandHandler : IRequestHandler<SetUserOrganizationCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _userContext;
    private readonly IUserClaimService _userClaimService;

    public SetUserOrganizationCommandHandler(
        IApplicationDbContext dbContext,
        IUserContext userContext,
        IUserClaimService userClaimService)
    {
        _dbContext = dbContext;
        _userContext = userContext;
        _userClaimService = userClaimService;
    }

    public async Task Handle(SetUserOrganizationCommand request, CancellationToken cancellationToken)
    {
        var organization = await _dbContext.Organizations
            .SingleEntityAsync(o => o.Id == request.OrganizationId);

        if (!organization.MemberUserIds.Contains(_userContext.UserId))
        {
            throw new UserNotBelongToOrganizationException();
        }

        await _userClaimService.SetUserCurrentOrganization(_userContext.UserId, organization.Id);
    }
}
