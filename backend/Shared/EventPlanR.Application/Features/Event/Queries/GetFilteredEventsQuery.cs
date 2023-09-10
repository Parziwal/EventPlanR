using EventPlanr.Application.Dto.Event;
using EventPlanr.Application.Mappings;
using EventPlanr.Domain.Enums;
using EventPlanr.Domain.Repositories;
using EventPlanr.Domain.Repositories.Models;
using MediatR;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetFilteredEventsQuery : IRequest<PaginatedList<EventDto>>
{
    public string? SearchTerm { get; set; }
    public EventCategory? Category { get; set; }
    public Language? Language { get; set; }
    public Currency? Currency { get; set; }
    public DateTimeOffset? FromDate { get; set; }
    public DateTimeOffset? ToDate { get; set; }
    public double? Latitude { get; set; }
    public double? Longitude { get; set; }
    public double? Radius { get; set; }
    public int PageNumber { get; set; }
    public int PageSize { get; set; }
}

public class GetFilteredEventsQueryHandler : IRequestHandler<GetFilteredEventsQuery, PaginatedList<EventDto>>
{
    private readonly IEventRepository _eventRepository;

    public GetFilteredEventsQueryHandler(IEventRepository eventRepository)
    {
        _eventRepository = eventRepository;
    }

    public async Task<PaginatedList<EventDto>> Handle(GetFilteredEventsQuery request, CancellationToken cancellationToken)
    {
        var events = await _eventRepository.GetEventsAsync(new EventFilter()
        {
            SearchTerm = request.SearchTerm,
            Category = request.Category,
            Language = request.Language,
            Currency = request.Currency,
            FromDate = request.FromDate,
            ToDate = request.ToDate,
            Location = request.Latitude is not null && request.Longitude is not null && request.Radius != null ? new LocationFilter()
            {
                Latitude = (double)request.Latitude,
                Longitude = (double)request.Longitude,
                Radius = (double)request.Radius,
            } : null,
        }, new PageData()
        {
            PageNumber = request.PageNumber,
            PageSize = request.PageSize,
        });
        return events.PaginatedListMapper((e) => e.ToEventDto());
    }
}