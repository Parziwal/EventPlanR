using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Organization;
using EventPlanr.Application.Models.Pagination;
using EventPlanr.Domain.Entities;
using MediatR;

namespace EventPlanr.Application.Features.Organization.Queries;

public class GetFilteredOrganizationsQuery : PageWithOrderDto, IRequest<PaginatedListDto<OrganizationDto>>
{
    public string? SearchTerm { get; set; }
}

public class GetFilteredOrganizationsQueryHandler : IRequestHandler<GetFilteredOrganizationsQuery, PaginatedListDto<OrganizationDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IMapper _mapper;

    public GetFilteredOrganizationsQueryHandler(IApplicationDbContext dbContext, IMapper mapper)
    {
        _dbContext = dbContext;
        _mapper = mapper;
    }

    public async Task<PaginatedListDto<OrganizationDto>> Handle(GetFilteredOrganizationsQuery request, CancellationToken cancellationToken)
    {
        return await _dbContext.Organizations
            .Where(request.SearchTerm != null, o => o.Name.ToLower().Contains(request.SearchTerm!.ToLower())
                || (o.Description != null && o.Description.ToLower().Contains(request.SearchTerm.ToLower())))
            .OrderBy<OrganizationEntity, OrganizationDto>(request, _mapper.ConfigurationProvider, o => o.Name)
            .ProjectTo<OrganizationDto>(_mapper.ConfigurationProvider)
            .ToPaginatedListAsync(request);
    }
}
