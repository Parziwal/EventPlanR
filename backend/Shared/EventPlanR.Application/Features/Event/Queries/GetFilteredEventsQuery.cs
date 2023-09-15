using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Mappings;
using EventPlanr.Application.Models.Common;
using EventPlanr.Application.Models.Event;
using EventPlanr.Application.Models.Pagination;
using EventPlanr.Domain.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetFilteredEventsQuery : PageWithOrderDto, IRequest<PaginatedListDto<EventDto>>
{
    public string? SearchTerm { get; set; }
    public EventCategory? Category { get; set; }
    public Language? Language { get; set; }
    public Currency? Currency { get; set; }
    public DateTimeOffset? FromDate { get; set; }
    public DateTimeOffset? ToDate { get; set; }
    public LocationDto? Location { get; set; }
}

public class GetFilteredEventsQueryHandler : IRequestHandler<GetFilteredEventsQuery, PaginatedListDto<EventDto>>
{
    private readonly IApplicationDbContext _context;

    public GetFilteredEventsQueryHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<PaginatedListDto<EventDto>> Handle(GetFilteredEventsQuery request, CancellationToken cancellationToken)
    {
        return await _context.Events
            .AsNoTracking()
            .Where(request.SearchTerm != null, e =>
                e.Name.ToLower().Contains(request.SearchTerm!.ToLower())
                || (e.Description != null && e.Description.ToLower().Contains(request.SearchTerm!.ToLower()))
                || e.Venue.ToLower().Contains(request.SearchTerm!.ToLower()))
            .Where(request.Category != null, e => e.Category == request.Category)
            .Where(request.Language != null, e => e.Language == request.Language)
            .Where(request.Currency != null, e => e.Currency == request.Currency)
            .Where(request.FromDate != null, e => e.FromDate >= request.FromDate)
            .Where(request.ToDate != null, e => e.ToDate <= request.ToDate)
            .Where(request.Location != null, e => e.Coordinates.GetDistance(request.Location!.ToCoordinates()) < request.Location!.Radius)
            .OrderBy(request, e => e.FromDate, OrderDirection.Descending)
            .Select(e => e.ToEventDto())
            .ToPaginatedListAsync(request);
    }
}