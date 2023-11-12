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

    public GetEventDetailsQueryHandler(IApplicationDbContext dbContext, IMapper mapper)
    {
        _dbContext = dbContext;
        _mapper = mapper;
    }

    public async Task<EventDetailsDto> Handle(GetEventDetailsQuery request, CancellationToken cancellationToken)
    {
        var eventEntity = await _dbContext.Events
            .AsNoTracking()
            .Include(e => e.Organization)
            .SingleEntityAsync(e => e.Id == request.EventId && !e.IsPrivate && e.IsPublished);
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
