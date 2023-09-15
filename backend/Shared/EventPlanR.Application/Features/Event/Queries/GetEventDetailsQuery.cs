using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Mappings;
using EventPlanr.Application.Models.Event;
using MediatR;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetEventDetailsQuery : IRequest<EventDetailsDto>
{
    public Guid EventId { get; set; }
}

public class GetEventDetailsQueryHandler : IRequestHandler<GetEventDetailsQuery, EventDetailsDto>
{
    private readonly IApplicationDbContext _context;

    public GetEventDetailsQueryHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<EventDetailsDto> Handle(GetEventDetailsQuery request, CancellationToken cancellationToken)
    {
        var eventEntity = await _context.Events
            .SingleEntityAsync(e => e.Id == request.EventId, request.EventId);
        return eventEntity.ToEventDetailsDto();
    }
}
