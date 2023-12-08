using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Event;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetEventDetailsQuery : IRequest<EventDetailsDto>
{
    public Guid EventId { get; set; }
}

public class GetEventDetailsQueryHandler : IRequestHandler<GetEventDetailsQuery, EventDetailsDto>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IMapper _mapper;
    private readonly IUserContext _user;

    public GetEventDetailsQueryHandler(
        IApplicationDbContext dbContext,
        IMapper mapper,
        IUserContext user)
    {
        _dbContext = dbContext;
        _mapper = mapper;
        _user = user;
    }

    public async Task<EventDetailsDto> Handle(GetEventDetailsQuery request, CancellationToken cancellationToken)
    {
        Guid? userId = null;
        if (_user.IsAuthenticated)
        {
            userId = _user.UserId;
        }

        var eventEntity = await _dbContext.Events
            .AsNoTracking()
            .Include(e => e.Organization)
            .SingleEntityAsync(e => e.Id == request.EventId 
            && ((!e.IsPrivate && e.IsPublished) || e.Invitations.Any(i => i.UserId == userId) 
            || e.Tickets.SelectMany(t => t.SoldTickets).Any(st => st.Order.CustomerUserId == userId)));
        var latestNews = await _dbContext.NewsPosts
            .AsNoTracking()
            .Where(np => np.Event.Id == request.EventId)
            .OrderByDescending(np => np.Created)
            .FirstOrDefaultAsync();

        if (latestNews != null)
        {
            eventEntity.NewsPosts.Add(latestNews);
        }

        return _mapper.Map<EventDetailsDto>(eventEntity);
    }
}
