using EventPlanr.Application.Dto.Event;
using EventPlanr.Application.Mappings;
using EventPlanr.Domain.Repositories;
using MediatR;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetEventDetailsQuery : IRequest<EventDetailsDto>
{
    public Guid EventId { get; set; }
}

public class GetEventDetailsQueryHandler : IRequestHandler<GetEventDetailsQuery, EventDetailsDto>
{
    private readonly IEventRepository _eventRepository;

    public GetEventDetailsQueryHandler(IEventRepository eventRepository)
    {
        _eventRepository = eventRepository;
    }

    public async Task<EventDetailsDto> Handle(GetEventDetailsQuery request, CancellationToken cancellationToken)
    {
        var eventDetails = await _eventRepository.GetEventByIdAsync(request.EventId);
        return eventDetails.ToEventDetailsDto();
    }
}
