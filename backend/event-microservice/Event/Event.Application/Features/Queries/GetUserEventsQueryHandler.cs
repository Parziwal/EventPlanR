using Amazon.Lambda;
using Amazon.Lambda.Model;
using AutoMapper;
using Event.Application.Contracts;
using Event.Application.Dto;
using Event.Domain.Options;
using MediatR;
using Microsoft.Extensions.Options;
using System.Text.Json;

namespace Event.Application.Features.Queries;

public class GetUserEventsQueryHandler : IRequestHandler<GetUserEventsQuery, List<EventDto>>
{
    private readonly IEventRepository _eventRepository;
    private readonly IMapper _mapper;
    private readonly IAmazonLambda _amazonLambda;
    private readonly LambdaFunctionOptions _lambdaFunctionOptions;

    public GetUserEventsQueryHandler(
        IEventRepository eventRepository,
        IMapper mapper,
        IAmazonLambda amazonLambda,
        IOptions<LambdaFunctionOptions> lambdaFunctionOptions)
    {
        _eventRepository = eventRepository;
        _mapper = mapper;
        _amazonLambda = amazonLambda;
        _lambdaFunctionOptions = lambdaFunctionOptions.Value;
    }

    public async Task<List<EventDto>> Handle(GetUserEventsQuery request, CancellationToken cancellationToken)
    {
        var lambdaRequest = new InvokeRequest
        {
            FunctionName = _lambdaFunctionOptions.GetUserEventsFunctionName,
            Payload = JsonSerializer.Serialize(request.userId),
        };
        var result = await _amazonLambda.InvokeAsync(lambdaRequest);
        var eventIds = await JsonSerializer.DeserializeAsync<List<string>>(result.Payload) ?? new List<string>();
        var eventList = await _eventRepository.GetEventsByIdsAsync(eventIds);
        return _mapper.Map<List<EventDto>>(eventList);
    }
}
