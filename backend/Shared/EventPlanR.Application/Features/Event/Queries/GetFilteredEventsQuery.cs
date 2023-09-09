using EventPlanR.Application.Dto.Event;
using EventPlanR.Application.Mappings;
using EventPlanR.Domain.Common;
using EventPlanR.Domain.Enums;
using EventPlanR.Domain.Repositories;
using EventPlanR.Domain.Repositories.Models;
using MediatR;

namespace EventPlanR.Application.Features.Event.Queries;

public class GetFilteredEventsQuery : IRequest<List<EventDto>>
{
    public string? SearchTerm { get; set; }
    public EventCategory? Category { get; set; }
    public DateTimeOffset? FromDate { get; set; }
    public DateTimeOffset? ToDate { get; set; }
    public double? Latitude { get; set; }
    public double? Longitude { get; set; }
}

public class GetFilteredEventsQueryHandler : IRequestHandler<GetFilteredEventsQuery, List<EventDto>>
{
    private readonly IEventRepository _eventRepository;

    public GetFilteredEventsQueryHandler(IEventRepository eventRepository)
    {
        _eventRepository = eventRepository;
    }

    public async Task<List<EventDto>> Handle(GetFilteredEventsQuery request, CancellationToken cancellationToken)
    {
        var events = await _eventRepository.GetEventsAsync(new EventFilter()
        {
            SearchTerm = request.SearchTerm,
            Category = request.Category,
            FromDate = request.FromDate,
            ToDate = request.ToDate,
            Coordinates = request.Latitude is not null && request.Longitude is not null ? new Coordinates()
            {
                Latitude = (double)request.Latitude,
                Longitude = (double)request.Longitude,
            } : null
        }, cancellationToken);
        return events.Select(e => e.ToEventDto())
            .ToList();
    }
}