using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Event;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;

namespace EventPlanr.Application.Features.Event.Queries;

[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationEventView)]
public class GetOrganizationEventDetailsQuery : IRequest<OrganizationEventDetailsDto>
{
    public Guid EventId { get; set; }
}

public class GetOrganizationEventDetailsQueryHandler : IRequestHandler<GetOrganizationEventDetailsQuery, OrganizationEventDetailsDto>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IMapper _mapper;

    public GetOrganizationEventDetailsQueryHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IMapper mapper)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
    }

    public async Task<OrganizationEventDetailsDto> Handle(GetOrganizationEventDetailsQuery request, CancellationToken cancellationToken)
    {
        var eventEntity = await _dbContext.Events
            .SingleEntityAsync(e => e.Id == request.EventId && e.OrganizationId == _user.OrganizationId);

        return _mapper.Map<OrganizationEventDetailsDto>(eventEntity);
    }
}
