using EventPlanr.Application.Features.Ticket.Commands;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventPlanr.TicketManager.Api;

[ApiController]
[Route("ticketmanager")]
public class MainController : ControllerBase
{
    private readonly ISender _sender;

    public MainController(ISender sender)
    {
        _sender = sender;
    }

    [HttpPost("event/{eventId}")]
    public Task<Guid> AddTicketToEvent(Guid eventId, [FromBody] AddTicketToEventCommand command)
    {
        command.EventId = eventId;
        return _sender.Send(command);
    }

    [HttpPut("{ticketId}")]
    public Task UpdateTicket(Guid ticketId, [FromBody] UpdateTicketCommand command)
    {
        command.TicketId = ticketId;
        return _sender.Send(command);
    }

    [HttpDelete("{ticketId}")]
    public Task DeleteTicket(Guid ticketId)
        => _sender.Send(new DeleteTicketCommand()
        {
            TicketId = ticketId,
        });
}
