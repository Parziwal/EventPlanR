using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Models.User;
using EventPlanr.Application.Security;
using MediatR;

namespace EventPlanr.Application.Features.User.Queries;

[Authorize]
public class GetUserClaimQuery : IRequest<UserClaimDto>
{
    public Guid UserId { get; set; }
}

public class GetUserClaimsQueryHandler : IRequestHandler<GetUserClaimQuery, UserClaimDto>
{
    private readonly IUserClaimService _userClaimService;
    private readonly IMapper _mapper;

    public GetUserClaimsQueryHandler(IUserClaimService userClaimService, IMapper mapper)
    {
        _userClaimService = userClaimService;
        _mapper = mapper;
    }

    public async Task<UserClaimDto> Handle(GetUserClaimQuery request, CancellationToken cancellationToken)
    {
        var userClaim = await _userClaimService.GetUserClaimAsync(request.UserId);

        return _mapper.Map<UserClaimDto>(userClaim);
    }
}
