using MediatR;
using System.Text.Json.Serialization;

namespace EventPlanr.Application.Features.Organization.Commands;

public class AddMemberToOrganizationCommand : IRequest
{
    [JsonIgnore]
    public Guid OrganizationId { get; set; }
    public string UserEmail { get; set; } = null!;
}

public class AddMemberToOrganizationCommandHandler : IRequestHandler<AddMemberToOrganizationCommand>
{
    public Task Handle(AddMemberToOrganizationCommand request, CancellationToken cancellationToken)
    {
        throw new NotImplementedException();
    }
}
