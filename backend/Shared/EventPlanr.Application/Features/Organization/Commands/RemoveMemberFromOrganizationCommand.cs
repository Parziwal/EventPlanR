using FluentValidation;
using MediatR;

namespace EventPlanr.Application.Features.Organization.Commands;

public class RemoveMemberFromOrganizationCommand : IRequest
{
    public Guid OrganizationId { get; set; }
    public Guid UserId { get; set; }
}

public class RemoveMemberFromOrganizationCommandHandler : IRequestHandler<RemoveMemberFromOrganizationCommand>
{
    public Task Handle(RemoveMemberFromOrganizationCommand request, CancellationToken cancellationToken)
    {
        throw new NotImplementedException();
    }
}
