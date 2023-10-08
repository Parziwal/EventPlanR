using EventPlanr.Application.Contracts;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using EventPlanr.Domain.Entities;
using MediatR;

namespace EventPlanr.Application.Features.Organization.Commands;

[Authorize]
public class CreateOrganizationCommand : IRequest<Guid>
{
    public string Name { get; set; } = null!;
    public string? Description { get; set; }
}

public class CreateOrganizationCommandHandler : IRequestHandler<CreateOrganizationCommand, Guid>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IUserClaimService _userClaimService;

    public CreateOrganizationCommandHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IUserClaimService userClaimService)
    {
        _dbContext = dbContext;
        _user = user;
        _userClaimService = userClaimService;
    }

    public async Task<Guid> Handle(CreateOrganizationCommand request, CancellationToken cancellationToken)
    {
        var organization = new OrganizationEntity()
        {
            Name = request.Name,
            Description = request.Description,
            MemberUserIds = new List<Guid>() { _user.UserId },
        };

        _dbContext.Organizations.Add(organization);
        await _dbContext.SaveChangesAsync();

        var organizationPolicy = new OrganizationPolicyEntity()
        {
            OrganizationId = organization.Id,
            Policies = new List<string>()
            {
                OrganizationPolicies.OrganizationManage,
                OrganizationPolicies.OrganizationEventManage,
            }
        };
        await _userClaimService.PutOrganizationToUserAsync(_user.UserId, organizationPolicy);

        return organization.Id;
    }
}