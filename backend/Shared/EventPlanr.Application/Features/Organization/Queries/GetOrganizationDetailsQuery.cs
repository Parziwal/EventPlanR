using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Organization;
using MediatR;

namespace EventPlanr.Application.Features.Organization.Queries;

public class GetOrganizationDetailsQuery : IRequest<OrganizationDetailsDto>
{
    public Guid OrganizationId { get; set; }
}

public class GetOrganizationDetailsQueryHandler : IRequestHandler<GetOrganizationDetailsQuery, OrganizationDetailsDto>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IMapper _mapper;

    public GetOrganizationDetailsQueryHandler(IApplicationDbContext dbContext, IMapper mapper)
    {
        _dbContext = dbContext;
        _mapper = mapper;
    }

    public async Task<OrganizationDetailsDto> Handle(GetOrganizationDetailsQuery request, CancellationToken cancellationToken)
    {
        var organization = await _dbContext.Organizations
            .SingleEntityAsync(o => o.Id == request.OrganizationId);

        return _mapper.Map<OrganizationDetailsDto>(organization);
    }
}