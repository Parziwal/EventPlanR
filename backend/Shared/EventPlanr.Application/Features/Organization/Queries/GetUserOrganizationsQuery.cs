using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Models.Organization;
using EventPlanr.Application.Security;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Organization.Queries;

[Authorize]
public class GetUserOrganizationsQuery : IRequest<List<OrganizationDto>>
{
}

public class GetUserOrganizationsQueryHandler : IRequestHandler<GetUserOrganizationsQuery, List<OrganizationDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _userContext;
    private readonly IMapper _mapper;

    public GetUserOrganizationsQueryHandler(
        IApplicationDbContext dbContext,
        IUserContext userContext,
        IMapper mapper)
    {
        _dbContext = dbContext;
        _userContext = userContext;
        _mapper = mapper;
    }

    public async Task<List<OrganizationDto>> Handle(GetUserOrganizationsQuery request, CancellationToken cancellationToken)
    {
        return await _dbContext.Organizations
            .AsNoTracking()
            .Where(o => o.MemberUserIds.Contains(_userContext.UserId))
            .OrderBy(o => o.Name)
            .ProjectTo<OrganizationDto>(_mapper.ConfigurationProvider)
            .ToListAsync();
    }
}
