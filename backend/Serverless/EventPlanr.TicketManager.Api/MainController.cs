using EventPlanr.Application.Features.Ticket.Commands;
using EventPlanr.Application.Features.Ticket.Queries;
using EventPlanr.Application.Models.Ticket;
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

    [HttpGet("event/{eventId}")]
    public Task<List<OrganizationTicketDto>> GetOrganizationEventTickets(Guid eventId)
        => _sender.Send(new GetOrganizationEventTicketsQuery() {
            EventId = eventId,
        });

    [HttpPost("event/{eventId}")]
    public Task<Guid> AddTicketToEvent(Guid eventId, [FromBody] AddTicketToEventCommand command)
    {
        command.EventId = eventId;
        return _sender.Send(command);
    }

    [HttpPut("{ticketId}")]
    public Task EditTicket(Guid ticketId, [FromBody] EditTicketCommand command)
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

    [HttpPost("refund/{soldTicketId}")]
    public Task RefundTicket(Guid soldTicketId)
        => _sender.Send(new RefundTicketCommand()
        {
            SoldTicketId = soldTicketId,
        });
}
