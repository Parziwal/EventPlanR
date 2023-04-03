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
    public Task<List<EventDto>> GetAllEvents() => _mediator.Send(new GetEventListQuery());
}
