using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using MediatR;
using System.Text.Json.Serialization;

namespace EventPlanr.Application.Features.Organization.Commands;

public class UpdateOrganizationCommand : IRequest
{
    [JsonIgnore]
    public Guid OrganizationId { get; set; }
    public string? Description { get; set; }
}

public class UpdateOrganizationCommandHandler : IRequestHandler<UpdateOrganizationCommand>
{
    private readonly IApplicationDbContext _context;
    private readonly IUserContext _user;

    public UpdateOrganizationCommandHandler(IApplicationDbContext context, IUserContext user)
    {
        _context = context;
        _user = user;
    }

    public async Task Handle(UpdateOrganizationCommand request, CancellationToken cancellationToken)
    {
        if (_user.OrganizationIds.Contains(request.OrganizationId.ToString()))
        {
            throw new UserNotBelongToOrganizationException(_user.UserId, request.OrganizationId.ToString());
        }

        var organization = await _context.Organizations
            .SingleEntityAsync(o => o.Id == request.OrganizationId);

        organization.Description = request.Description;

        await _context.SaveChangesAsync();
    }
}
