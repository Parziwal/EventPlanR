using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Mappings;
using EventPlanr.Application.Models.Event;
using EventPlanr.Application.Models.Pagination;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetUserUpcomingEventsQuery : PageDto, IRequest<PaginatedListDto<EventDto>>
{
    public string? SearchTerm { get; set; }
}

public class GetUserUpcomingEventsQueryHandler : IRequestHandler<GetUserUpcomingEventsQuery, PaginatedListDto<EventDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly IUserContext _user;

    public GetUserUpcomingEventsQueryHandler(IApplicationDbContext context, IUserContext user)
    {
        _context = context;
        _user = user;
    }

    public async Task<PaginatedListDto<EventDto>> Handle(GetUserUpcomingEventsQuery request, CancellationToken cancellationToken)
    {
        return await _context.Events
            .AsNoTracking()
            .Where(e => e.Tickets.Any(t => t.SoldTickets.Any(st => st.Order.CustomerUserId == _user.UserId)))
            .Where(e => e.FromDate >= DateTimeOffset.Now)
            .Where(request.SearchTerm != null, e =>
                e.Name.ToLower().Contains(request.SearchTerm!.ToLower())
                || (e.Description != null && e.Description.ToLower().Contains(request.SearchTerm!.ToLower()))
                || e.Venue.ToLower().Contains(request.SearchTerm!.ToLower()))
            .OrderByDescending(e => e.FromDate)
            .Select(e => e.ToEventDto())
            .ToPaginatedListAsync(request);
    }
}
