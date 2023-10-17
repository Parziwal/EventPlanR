using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Organization;
using EventPlanr.Application.Models.User;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;
using Microsoft.EntityFrameworkCore;

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
    private readonly IUserClaimService _userClaimService;

    public GetUserCurrentOrganizationDetailsQueryHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IMapper mapper,
        IUserService userService,
        IUserClaimService userClaimService)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
        _userService = userService;
        _userClaimService = userClaimService;
    }

    public async Task<UserOrganizationDetailsDto> Handle(GetUserCurrentOrganizationDetailsQuery request, CancellationToken cancellationToken)
    {
        var organization = await _dbContext.Organizations
            .AsNoTracking()
            .SingleEntityAsync(o => o.Id == _user.OrganizationId);

        var members = new List<OrganizationMemberDto>();

        foreach (var userId in organization.MemberUserIds)
        {
            if (userId == _user.UserId)
            {
                continue;
            }

            var userEntity = await _userService.GetUserById(userId);
            var userDto = _mapper.Map<OrganizationMemberDto>(userEntity);
            var claim = await _userClaimService.GetUserClaimAsync(userId);
            userDto.OrganizationPolicies = claim.Organizations
                .Single(o => o.OrganizationId == organization.Id)
                .Policies;
            members.Add(userDto);
        }

        return _mapper.Map<UserOrganizationDetailsDto>(organization, opt =>
            opt.AfterMap((src, dest) => dest.Members = members));
    }
}
