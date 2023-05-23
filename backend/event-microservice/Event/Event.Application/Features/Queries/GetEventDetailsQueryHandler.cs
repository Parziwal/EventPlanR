using AutoMapper;
using Event.Application.Contracts;
using Event.Application.Dto;
using MediatR;

namespace Event.Application.Features.Queries;

public class GetEventDetailsQueryHandler : IRequestHandler<GetEventDetailsQuery, EventDetailsDto>
{
    private readonly IEventRepository _eventRepository;
    private readonly IMapper _mapper;

    public GetEventDetailsQueryHandler(IEventRepository eventRepository, IMapper mapper)
    {
        _eventRepository = eventRepository;
        _mapper = mapper;
    }

    public async Task<EventDetailsDto> Handle(GetEventDetailsQuery request, CancellationToken cancellationToken)
    {
        var eventDetails = await _eventRepository.GetEventByIdAsync(request.eventId);
        return _mapper.Map<EventDetailsDto>(eventDetails);
    }
}
