using Event.Application.Dto;
using Event.Application.Features.Queries;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventGeneral.API.Controllers;

[ApiController]
[Route("[controller]")]
public class EventController : ControllerBase
{
    private readonly IMediator _mediator;

    public EventController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet]
    public Task<List<EventDto>> GetEventList([FromQuery] EventFilterDto filter)
        => _mediator.Send(new GetEventListQuery(filter));


    [HttpGet("{id}")]
    public Task<EventDetailsDto> GetEventDetails(Guid id)
        => _mediator.Send(new GetEventDetailsQuery(id));

    [HttpGet("user/{userId}")]
    public Task<List<EventDto>> GetUserEvents(string userId)
        => _mediator.Send(new GetUserEventsQuery(userId));
}
