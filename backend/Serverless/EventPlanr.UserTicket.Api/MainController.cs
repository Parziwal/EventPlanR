using EventPlanr.Application.Features.Event.Queries;
using EventPlanr.Application.Features.Ticket.Queries;
using EventPlanr.Application.Models.Event;
using EventPlanr.Application.Models.Pagination;
using EventPlanr.Application.Models.Ticket;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventPlanr.UserTicket.Api;

[ApiController]
[Route("userticket")]
public class MainController : ControllerBase
{
    private readonly ISender _sender;

    public MainController(ISender sender)
    {
        _sender = sender;
    }

    [HttpGet("upcoming")]
    public Task<PaginatedListDto<EventDto>> GetUserUpcomingEvents([FromQuery] GetUserUpcomingEventsQuery query)
        => _sender.Send(query);

    [HttpGet("invitation")]
    public Task<PaginatedListDto<EventDto>> GetUserEventInvitations([FromQuery] GetUserInvitationEventsQuery query)
        => _sender.Send(query);

    [HttpGet("past")]
    public Task<PaginatedListDto<EventDto>> GetUserEventInvitations([FromQuery] GetUserPastEventsQuery query)
        => _sender.Send(query);

    [HttpGet("{eventId}")]
    public Task<List<SoldTicketDto>> GetUserEventTickets(Guid eventId)
        => _sender.Send(new GetUserEventTicketsQuery()
        {
            EventId = eventId,
        });
}
