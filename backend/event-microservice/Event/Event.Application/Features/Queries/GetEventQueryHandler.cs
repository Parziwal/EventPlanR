using AutoMapper;
using Event.Application.Contracts;
using Event.Application.Dto;
using MediatR;

namespace Event.Application.Features.Queries;

public class GetEventListQueryHandler : IRequestHandler<GetEventListQuery, List<EventDto>>
{
    private readonly IEventRepository _eventRepository;
    private readonly IMapper _mapper;

    public GetEventListQueryHandler(IEventRepository eventRepository, IMapper mapper)
    {
        _eventRepository = eventRepository;
        _mapper = mapper;
    }

    public async Task<List<EventDto>> Handle(GetEventListQuery request, CancellationToken cancellationToken)
    {
        var eventList = await _eventRepository.GetEventsAsync(request.filter);
        return _mapper.Map<List<EventDto>>(eventList);
    }
}
