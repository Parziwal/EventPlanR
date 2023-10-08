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
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;

    public GetEventDetailsQueryHandler(IApplicationDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<EventDetailsDto> Handle(GetEventDetailsQuery request, CancellationToken cancellationToken)
    {
        var eventEntity = await _context.Events
            .AsNoTracking()
            .Include(e => e.Organization)
            .SingleEntityAsync(e => e.Id == request.EventId);
        var latestNews = await _context.NewsPosts
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
