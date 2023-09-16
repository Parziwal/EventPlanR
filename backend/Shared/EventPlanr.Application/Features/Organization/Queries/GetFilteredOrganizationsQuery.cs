using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Organization;
using EventPlanr.Application.Models.Pagination;
using MediatR;
using Entities = EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Features.Organization.Queries;

public class GetFilteredOrganizationsQuery : PageWithOrderDto, IRequest<PaginatedListDto<OrganizationDto>>
{
    public string? SearchTerm { get; set; }
}

public class GetFilteredOrganizationsQueryHandler : IRequestHandler<GetFilteredOrganizationsQuery, PaginatedListDto<OrganizationDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;

    public GetFilteredOrganizationsQueryHandler(IApplicationDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<PaginatedListDto<OrganizationDto>> Handle(GetFilteredOrganizationsQuery request, CancellationToken cancellationToken)
    {
        return await _context.Organizations
            .Where(request.SearchTerm != null, o => o.Name.ToLower().Contains(request.SearchTerm!.ToLower())
                || (o.Description != null && o.Description.ToLower().Contains(request.SearchTerm.ToLower())))
            .OrderBy<Entities.Organization, OrganizationDto>(request, _mapper.ConfigurationProvider, o => o.Name)
            .ProjectTo<OrganizationDto>(_mapper.ConfigurationProvider)
            .ToPaginatedListAsync(request);
    }
}
