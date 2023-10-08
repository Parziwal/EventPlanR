using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions.Organization;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Organization;
using EventPlanr.Application.Models.User;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;

namespace EventPlanr.Application.Features.Organization.Queries;

[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationView)]
public class GetUserCurrentOrganizationDetailsQuery : IRequest<UserOrganizationDetailsDto>
{
}

public class GetUserCurrentOrganizationDetailsQueryHandler : IRequestHandler<GetUserCurrentOrganizationDetailsQuery, UserOrganizationDetailsDto>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IMapper _mapper;
    private readonly IUserService _userService;

    public GetUserCurrentOrganizationDetailsQueryHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IMapper mapper,
        IUserService userService)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
        _userService = userService;
    }

    public async Task<UserOrganizationDetailsDto> Handle(GetUserCurrentOrganizationDetailsQuery request, CancellationToken cancellationToken)
    {
        if (_user.OrganizationId == null)
        {
            throw new OrganizationNotSelectedException();
        }

        var organization = await _dbContext.Organizations
            .SingleEntityAsync(o => o.Id == _user.OrganizationId);

        var members = new List<UserDto>();

        foreach (var userId in organization.MemberUserIds)
        {
            var userEntity = await _userService.GetUserById(userId);
            var userDto = _mapper.Map<UserDto>(userEntity);
            members.Add(userDto);
        }

        return _mapper.Map<UserOrganizationDetailsDto>(organization, opt =>
            opt.AfterMap((src, dest) => dest.Members = members));
    }
}
