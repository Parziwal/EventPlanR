using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions.Organization;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;

namespace EventPlanr.Application.Features.Organization.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationManage)]
public class DeleteOrganizationCommand : IRequest
{
    public Guid OrganizationId { get; set; }
}

public class DeleteOrganizationCommandHandler : IRequestHandler<DeleteOrganizationCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IUserClaimService _userClaimService;

    public DeleteOrganizationCommandHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IUserClaimService userClaimService)
    {
        _dbContext = dbContext;
        _user = user;
        _userClaimService = userClaimService;
    }

    public async Task Handle(DeleteOrganizationCommand request, CancellationToken cancellationToken)
    {
        if (request.OrganizationId != _user.OrganizationId)
        {
            throw new UserNotBelongToOrganizationException();
        }

        var organization = await _dbContext.Organizations
            .SingleEntityAsync(o => o.Id == request.OrganizationId);

        _dbContext.Organizations.Remove(organization);
        await _dbContext.SaveChangesAsync();

        foreach (var member in organization.MemberUserIds)
        {
            await _userClaimService.RemoveOrganizationFromUserAsync(member, organization.Id);
        }
    }
}
