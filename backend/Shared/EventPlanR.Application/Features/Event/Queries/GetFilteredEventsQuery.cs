using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Common;
using EventPlanr.Application.Models.Event;
using EventPlanr.Application.Models.Pagination;
using EventPlanr.Domain.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;
using NetTopologySuite.Geometries;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetFilteredEventsQuery : PageWithOrderDto, IRequest<PaginatedListDto<EventDto>>
{
    public string? SearchTerm { get; set; }
    public EventCategory? Category { get; set; }
    public Currency? Currency { get; set; }
    public DateTimeOffset? FromDate { get; set; }
    public DateTimeOffset? ToDate { get; set; }
    public LocationDto? Location { get; set; }
}

public class GetFilteredEventsQueryHandler : IRequestHandler<GetFilteredEventsQuery, PaginatedListDto<EventDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IMapper _mapper;

    public GetFilteredEventsQueryHandler(IApplicationDbContext dbContext, IMapper mapper)
    {
        _dbContext = dbContext;
        _mapper = mapper;
    }

    public async Task<PaginatedListDto<EventDto>> Handle(GetFilteredEventsQuery request, CancellationToken cancellationToken)
    {
        var filteredCoordinate = request.Location != null ? new Point(new Coordinate()
        {
            X = request.Location.Latitude,
            Y = request.Location.Longitude,
        }) : null;

        return await _dbContext.Events
            .AsNoTracking()
            .Include(e => e.Organization)
            .Where(e => !e.IsPrivate && e.IsPublished)
            .Where(request.SearchTerm != null, e =>
                e.Name.ToLower().Contains(request.SearchTerm!.ToLower())
                || (e.Description != null && e.Description.ToLower().Contains(request.SearchTerm!.ToLower()))
                || e.Venue.ToLower().Contains(request.SearchTerm!.ToLower()))
            .Where(request.Category != null, e => e.Category == request.Category)
            .Where(request.Currency != null, e => e.Currency == request.Currency)
            .Where(request.FromDate != null, e => e.FromDate >= request.FromDate)
            .Where(request.ToDate != null, e => e.ToDate <= request.ToDate)
            .Where(request.Location != null, e => e.Coordinate.Distance(filteredCoordinate!) < request.Location!.Radius)
            .OrderBy<Domain.Entities.EventEntity, EventDto>(request, _mapper.ConfigurationProvider, e => e.FromDate, OrderDirection.Descending)
            .ProjectTo<EventDto>(_mapper.ConfigurationProvider)
            .ToPaginatedListAsync(request);
    }
}