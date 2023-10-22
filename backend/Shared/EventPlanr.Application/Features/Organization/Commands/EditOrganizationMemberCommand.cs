using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using EventPlanr.Domain.Entities;
using MediatR;

namespace EventPlanr.Application.Features.Organization.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationManage)]
public class EditOrganizationMemberCommand : IRequest
{
    public Guid MemberUserId { get; set; }
    public List<string> Policies { get; set; } = new List<string>();
}

public class EditOrganizationMemberCommandHandler : IRequestHandler<EditOrganizationMemberCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IUserService _userService;
    private readonly IUserClaimService _userClaimService;

    public EditOrganizationMemberCommandHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IUserService userService,
        IUserClaimService userClaimService)
    {
        _dbContext = dbContext;
        _user = user;
        _userService = userService;
        _userClaimService = userClaimService;
    }

    public async Task Handle(EditOrganizationMemberCommand request, CancellationToken cancellationToken)
    {
        var organization = await _dbContext.Organizations
            .SingleEntityAsync(o => o.Id == _user.OrganizationId);

        if (!organization.MemberUserIds.Contains(request.MemberUserId))
        {
            throw new DomainException("UserNotBelongToOrganizationException");
        }

        await _userClaimService.PutOrganizationToUserAsync(request.MemberUserId, new OrganizationPolicyEntity()
        {
            OrganizationId = organization.Id,
            Policies = request.Policies,
        });
    }
}