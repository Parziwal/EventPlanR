using MediatR;

namespace EventPlanr.Application.Features.Organization.Commands;

public class DeleteOrganizationCommand : IRequest
{
    public Guid OrganizationId { get; set; }
}

public class DeleteOrganizationCommandHandler : IRequestHandler<DeleteOrganizationCommand>
{
    public Task Handle(DeleteOrganizationCommand request, CancellationToken cancellationToken)
    {
        throw new NotImplementedException();
    }
}
