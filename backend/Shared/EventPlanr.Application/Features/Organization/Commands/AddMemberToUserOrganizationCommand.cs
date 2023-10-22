using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using EventPlanr.Domain.Entities;
using MediatR;

namespace EventPlanr.Application.Features.Organization.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationManage)]
public class AddMemberToUserOrganizationCommand : IRequest
{
    public string MemberUserEmail { get; set; } = null!;
    public List<string> Policies { get; set; } = new List<string>();
}

public class AddMemberToUserOrganizationCommandHandler : IRequestHandler<AddMemberToUserOrganizationCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IUserService _userService;
    private readonly IUserClaimService _userClaimService;

    public AddMemberToUserOrganizationCommandHandler(
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

    public async Task Handle(AddMemberToUserOrganizationCommand request, CancellationToken cancellationToken)
    {
        var memberUserId = await _userService.GetUserIdByEmail(request.MemberUserEmail)
            ?? throw new EntityNotFoundException("UserEntity");

        var organization = await _dbContext.Organizations
            .SingleEntityAsync(o => o.Id == _user.OrganizationId);
        organization.MemberUserIds.Add(memberUserId);
        await _dbContext.SaveChangesAsync();

        await _userClaimService.PutOrganizationToUserAsync(memberUserId, new OrganizationPolicyEntity()
        {
            OrganizationId = organization.Id,
            Policies = request.Policies,
        });
    }
}
