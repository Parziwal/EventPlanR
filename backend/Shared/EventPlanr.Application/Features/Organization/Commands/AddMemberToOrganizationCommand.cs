using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions.Common;
using EventPlanr.Application.Exceptions.Organization;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using EventPlanr.Domain.Entities;
using MediatR;
using System.Text.Json.Serialization;

namespace EventPlanr.Application.Features.Organization.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationManage)]
public class AddMemberToOrganizationCommand : IRequest
{
    [JsonIgnore]
    public Guid OrganizationId { get; set; }
    public string MemberUserEmail { get; set; } = null!;
    public List<string> Policies { get; set; } = new List<string>();
}

public class AddMemberToOrganizationCommandHandler : IRequestHandler<AddMemberToOrganizationCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IUserService _userService;
    private readonly IUserClaimService _userClaimService;

    public AddMemberToOrganizationCommandHandler(
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

    public async Task Handle(AddMemberToOrganizationCommand request, CancellationToken cancellationToken)
    {
        if (request.OrganizationId != _user.OrganizationId)
        {
            throw new UserNotBelongToOrganizationException();
        }

        var memeberUserId = await _userService.GetUserIdByEmail(request.MemberUserEmail)
            ?? throw new EntityNotFoundException("UserEntity");

        var organization = await _dbContext.Organizations
            .SingleEntityAsync(o => o.Id == request.OrganizationId);
        organization.MemberUserIds.Add(memeberUserId);
        await _dbContext.SaveChangesAsync();

        await _userClaimService.PutOrganizationToUserAsync(organization.Id, new OrganizationPolicyEntity()
        {
            OrganizationId = organization.Id,
            Policies = request.Policies,
        });
    }
}
