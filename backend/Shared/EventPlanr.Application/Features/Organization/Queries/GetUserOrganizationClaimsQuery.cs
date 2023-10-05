using EventPlanr.Application.Contracts;
using MediatR;

namespace EventPlanr.Application.Features.Organization.Queries;

public class GetUserOrganizationClaimsQuery : IRequest<List<Guid>>
{
    public Guid UserId { get; set; }
}

public class GetUserOrganizationClaimsQueryHandler : IRequestHandler<GetUserOrganizationClaimsQuery, List<Guid>>
{
    private readonly IUserService _userService;

    public GetUserOrganizationClaimsQueryHandler(IUserContext user, IUserService userService)
    {
        _userService = userService;
    }

    public Task<List<Guid>> Handle(GetUserOrganizationClaimsQuery request, CancellationToken cancellationToken)
    {
        return _userService.GetUserOrganizationsAsync(request.UserId);
    }
}
