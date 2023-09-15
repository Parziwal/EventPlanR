using EventPlanr.Application.Contracts;
using EventPlanr.Application.Features.Event.Queries;
using EventPlanr.Application.Models.Event;
using EventPlanr.Application.Models.Pagination;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventPlanr.EventGeneral.Api;

[Route("event/general")]
[ApiController]
public class EventGeneralController : ControllerBase
{
    private readonly ISender _sender;
    private readonly IUserContext u;

    public EventGeneralController(ISender sender, IUserContext user)
    {
        _sender = sender;
        u = user;
    }

    [HttpGet("Test")]
    public void GetFiltereEvents()
    {
        var a = u;
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
