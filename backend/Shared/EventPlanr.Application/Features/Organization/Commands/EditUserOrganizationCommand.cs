using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;

namespace EventPlanr.Application.Features.Organization.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationManage)]
public class EditUserOrganizationCommand : IRequest
{
    public string? Description { get; set; }
}

public class EditUserOrganizationCommandHandler : IRequestHandler<EditUserOrganizationCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public EditUserOrganizationCommandHandler(IApplicationDbContext dbContext, IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task Handle(EditUserOrganizationCommand request, CancellationToken cancellationToken)
    {
        var organization = await _dbContext.Organizations
            .SingleEntityAsync(o => o.Id == _user.OrganizationId);

        organization.Description = request.Description;

        await _dbContext.SaveChangesAsync();
    }
}
