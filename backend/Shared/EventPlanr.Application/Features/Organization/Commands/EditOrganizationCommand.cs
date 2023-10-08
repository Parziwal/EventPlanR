using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions.Organization;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;
using System.Text.Json.Serialization;

namespace EventPlanr.Application.Features.Organization.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationManage)]
public class EditOrganizationCommand : IRequest
{
    [JsonIgnore]
    public Guid OrganizationId { get; set; }
    public string? Description { get; set; }
}

public class EditOrganizationCommandHandler : IRequestHandler<EditOrganizationCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public EditOrganizationCommandHandler(IApplicationDbContext dbContext, IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task Handle(EditOrganizationCommand request, CancellationToken cancellationToken)
    {
        if (request.OrganizationId != _user.OrganizationId)
        {
            throw new UserNotBelongToOrganizationException();
        }

        var organization = await _dbContext.Organizations
            .SingleEntityAsync(o => o.Id == request.OrganizationId);

        organization.Description = request.Description;

        await _dbContext.SaveChangesAsync();
    }
}
