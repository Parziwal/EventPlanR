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
public class GetUserUpcomingEventsQuery : PageDto, IRequest<PaginatedListDto<EventDto>>
{
    public string? SearchTerm { get; set; }
}

public class GetUserUpcomingEventsQueryHandler : IRequestHandler<GetUserUpcomingEventsQuery, PaginatedListDto<EventDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IMapper _mapper;
    private readonly IUserContext _user;
    private readonly ITimeRepository _timeRepository;

    public GetUserUpcomingEventsQueryHandler(
        IApplicationDbContext dbContext,
        IMapper mapper,
        IUserContext user,
        ITimeRepository timeRepository)
    {
        _dbContext = dbContext;
        _mapper = mapper;
        _user = user;
        _timeRepository = timeRepository;
    }

    public async Task<PaginatedListDto<EventDto>> Handle(GetUserUpcomingEventsQuery request, CancellationToken cancellationToken)
    {
        var timeNow = _timeRepository.GetCurrentUtcTime();
        return await _dbContext.Events
            .AsNoTracking()
            .Include(e => e.Organization)
            .Where(e => e.Tickets.Any(t => t.SoldTickets.Any(st => st.Order.CustomerUserId == _user.UserId)))
            .Where(e => e.ToDate >= timeNow)
            .Where(request.SearchTerm != null, e =>
                e.Name.ToLower().Contains(request.SearchTerm!.ToLower())
                || (e.Description != null && e.Description.ToLower().Contains(request.SearchTerm!.ToLower()))
                || e.Venue.ToLower().Contains(request.SearchTerm!.ToLower()))
            .OrderByDescending(e => e.FromDate)
            .ProjectTo<EventDto>(_mapper.ConfigurationProvider)
            .ToPaginatedListAsync(request);
    }
}
