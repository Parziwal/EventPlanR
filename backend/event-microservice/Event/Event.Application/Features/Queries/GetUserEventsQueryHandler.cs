using Amazon.Lambda;
using Amazon.Lambda.Model;
using AutoMapper;
using Event.Application.Contracts;
using Event.Application.Dto;
using MediatR;
using System.Text.Json;

namespace Event.Application.Features.Queries;

public class GetUserEventsQueryHandler : IRequestHandler<GetUserEventsQuery, List<EventDto>>
{
    private readonly IEventRepository _eventRepository;
    private readonly IMapper _mapper;
    private readonly IAmazonLambda _amazonLambda;

    public GetUserEventsQueryHandler(IEventRepository eventRepository, IMapper mapper, IAmazonLambda amazonLambda)
    {
        _eventRepository = eventRepository;
        _mapper = mapper;
        _amazonLambda = amazonLambda;
    }

    public async Task<List<EventDto>> Handle(GetUserEventsQuery request, CancellationToken cancellationToken)
    {
        var lambdaRequest = new InvokeRequest
        {
            FunctionName = "get_user_events",
            Payload = JsonSerializer.Serialize(request.userId),
        };
        var result = await _amazonLambda.InvokeAsync(lambdaRequest);
        var eventIds = await JsonSerializer.DeserializeAsync<List<string>>(result.Payload) ?? new List<string>();
        var eventList = await _eventRepository.GetEventsByIdsAsync(eventIds);
        return _mapper.Map<List<EventDto>>(eventList);
    }
}
