using EventPlanr.Application.Dto.Common;
using EventPlanr.Application.Dto.Event;
using EventPlanr.Application.Features.Event.Queries;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventPlanr.EventGeneral.Api;

[Route("event/general")]
[ApiController]
public class EventGeneralController : ControllerBase
{
    private readonly ISender _sender;

    public EventGeneralController(ISender sender)
    {
        _sender = sender;
    }

    [HttpGet]
    public Task<PaginatedListDto<EventDto>> GetFilteredEvents([FromQuery] GetFilteredEventsQuery query)
        => _sender.Send(query);

    [HttpGet("/{eventId}")]
    public Task<EventDetailsDto> GetEventDetails(Guid eventId)
        => _sender.Send(new GetEventDetailsQuery()
        {
            EventId = eventId,
        });
}
