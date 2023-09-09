using EventPlanR.Application.Dto.Event;
using EventPlanR.Application.Mappings;
using EventPlanR.Domain.Repositories;
using MediatR;

namespace EventPlanR.Application.Features.Event.Queries;

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
