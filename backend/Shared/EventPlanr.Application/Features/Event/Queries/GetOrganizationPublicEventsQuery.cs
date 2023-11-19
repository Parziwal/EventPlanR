using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Event;
using EventPlanr.Application.Models.Pagination;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetOrganizationPublicEventsQuery : PageDto, IRequest<PaginatedListDto<EventDto>>
{
    public Guid OrganizationId { get; set; }
}

public class GetOrganizationPublicEventsQueryHandler : IRequestHandler<GetOrganizationPublicEventsQuery, PaginatedListDto<EventDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IMapper _mapper;

    public GetOrganizationPublicEventsQueryHandler(IApplicationDbContext dbContext, IMapper mapper)
    {
        _dbContext = dbContext;
        _mapper = mapper;
    }

    public Task<PaginatedListDto<EventDto>> Handle(GetOrganizationPublicEventsQuery request, CancellationToken cancellationToken)
    {
        return _dbContext.Events
            .AsNoTracking()
            .Include(e => e.Organization)
            .Where(e => e.OrganizationId == request.OrganizationId)
            .Where(e => !e.IsPrivate && e.IsPublished)
            .OrderByDescending(e => e.FromDate)
            .ProjectTo<EventDto>(_mapper.ConfigurationProvider)
            .ToPaginatedListAsync(request);
    }
}