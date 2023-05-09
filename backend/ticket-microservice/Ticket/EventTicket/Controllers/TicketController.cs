using MediatR;
using Microsoft.AspNetCore.Mvc;
using Ticket.Application.Dto;
using Ticket.Application.Features.Commands;
using Ticket.Application.Features.Queries;

namespace EventTicket.Controllers;

[Route("[controller]")]
[ApiController]
public class TicketController : ControllerBase
{
    private readonly IMediator _mediator;

    public TicketController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet("event/{eventId}")]
    public Task<List<EventTicketDto>> GetEventTickets(string eventId)
        => _mediator.Send(new GetEventTicketsQuery(eventId));

    [HttpGet("event/{eventId}/user/{userId}")]
    public Task<List<UserTicketDto>> GetUserTickets(string eventId, string userId)
        => _mediator.Send(new GetUserTicketQuery(eventId, userId));

    [HttpPost("event/{eventId}/user/{userId}")]
    public Task BuyTicket(string eventId, string userId, [FromBody] List<BuyTicketDto> tickets)
        => _mediator.Send(new BuyTicketCommand(eventId, userId, tickets));
}
