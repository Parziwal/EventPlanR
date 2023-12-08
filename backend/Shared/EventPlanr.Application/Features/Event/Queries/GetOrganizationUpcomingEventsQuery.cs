using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Event;
using EventPlanr.Application.Models.Pagination;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Repository;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Event.Queries;

[Authorize]
public class GetOrganizationUpcomingEventsQuery : PageDto, IRequest<PaginatedListDto<OrganizationEventDto>>
{
    public string? SearchTerm { get; set; }
}

public class GetOrganizationUpcomingEventsQueryHandler : IRequestHandler<GetOrganizationUpcomingEventsQuery, PaginatedListDto<OrganizationEventDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IMapper _mapper;
    private readonly ITimeRepository _timeRepository;

    public GetOrganizationUpcomingEventsQueryHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IMapper mapper,
        ITimeRepository timeRepository)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
        _timeRepository = timeRepository;
    }

    public async Task<PaginatedListDto<OrganizationEventDto>> Handle(GetOrganizationUpcomingEventsQuery request, CancellationToken cancellationToken)
    {
        var timeNow = _timeRepository.GetCurrentUtcTime();
        return await _dbContext.Events
            .AsNoTracking()
            .Where(e => e.OrganizationId == _user.OrganizationId)
            .Where(e => e.IsPublished && e.ToDate >= timeNow)
            .Where(request.SearchTerm != null, e =>
                e.Name.ToLower().Contains(request.SearchTerm!.ToLower())
                || (e.Description != null && e.Description.ToLower().Contains(request.SearchTerm!.ToLower())))
            .OrderBy(e => e.FromDate)
            .ProjectTo<OrganizationEventDto>(_mapper.ConfigurationProvider)
            .ToPaginatedListAsync(request);
    }
}
