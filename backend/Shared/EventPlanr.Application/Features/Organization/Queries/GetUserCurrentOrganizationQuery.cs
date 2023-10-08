using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions.Organization;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Organization;
using MediatR;

namespace EventPlanr.Application.Features.Organization.Queries;

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
        if (_user.OrganizationId == null)
        {
            throw new OrganizationNotSelectedException();
        }

        var organization = await _dbContext.Organizations
            .SingleEntityAsync(o => o.Id == _user.OrganizationId);

        return _mapper.Map<OrganizationDto>(organization);
    }
}