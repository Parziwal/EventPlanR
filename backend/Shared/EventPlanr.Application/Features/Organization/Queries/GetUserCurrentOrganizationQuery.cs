using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Organization;
using EventPlanr.Application.Security;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Organization.Queries;

[Authorize]
public class GetUserCurrentOrganizationQuery : IRequest<OrganizationDto>
{
}

public class GetUserCurrentOrganizationQueryHandler : IRequestHandler<GetUserCurrentOrganizationQuery, OrganizationDto>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IMapper _mapper;

    public GetUserCurrentOrganizationQueryHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IMapper mapper)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
    }

    public async Task<OrganizationDto> Handle(GetUserCurrentOrganizationQuery request, CancellationToken cancellationToken)
    {
        var organization = await _dbContext.Organizations
            .AsNoTracking()
            .SingleEntityAsync(o => o.Id == _user.OrganizationId);

        return _mapper.Map<OrganizationDto>(organization);
    }
}