using EventPlanr.Application.Features.Event.Commands;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventPlanr.EventManager.Api;

[ApiController]
[Route("[controller]")]
public class EventManagerController : ControllerBase
{
    private readonly ISender _sender;

    public EventManagerController(ISender sender)
    {
        _sender = sender;
    }

    [HttpGet]
    public void GetOrganizationEvents()
    {
    }

    [HttpPost]
    public Task<Guid> CreateEvent([FromBody] CreateEventCommand command)
        => _sender.Send(command);


    [HttpPut("/{eventId}")]
    public Task UpdateEvent(Guid eventId, [FromBody] UpdateEventCommand command)
    {
        command.EventId = eventId;
        return _sender.Send(command);
    }

    [HttpDelete("/{eventId}")]
    public Task DeleteEvent(Guid eventId)
        => _sender.Send(new DeleteEventCommand()
        {
            EventId = eventId,
        });
}
