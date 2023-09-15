using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Mappings;
using EventPlanr.Application.Models.Event;
using EventPlanr.Application.Models.Pagination;
using MediatR;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetUserPastEventsQuery : PageDto, IRequest<PaginatedListDto<EventDto>>
{
    public string? SearchTerm { get; set; }
}

public class GetUserPastEventsQueryHandler : IRequestHandler<GetUserPastEventsQuery, PaginatedListDto<EventDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly IUserContext _user;

    public GetUserPastEventsQueryHandler(IApplicationDbContext context, IUserContext user)
    {
        _context = context;
        _user = user;
    }

    public async Task<PaginatedListDto<EventDto>> Handle(GetUserPastEventsQuery request, CancellationToken cancellationToken)
    {
        return await _context.Orders
            .Where(o => o.CustomerUserId == _user.UserId)
            .Select(o => o.SoldTickets.First().Ticket.Event)
            .Where(e => e.FromDate < DateTimeOffset.Now)
            .Where(request.SearchTerm != null, e =>
                e.Name.ToLower().Contains(request.SearchTerm!.ToLower())
                || (e.Description != null && e.Description.ToLower().Contains(request.SearchTerm!.ToLower()))
                || e.Venue.ToLower().Contains(request.SearchTerm!.ToLower()))
            .OrderByDescending(e => e.FromDate)
            .Select(e => e.ToEventDto())
            .ToPaginatedListAsync(request);
    }
}