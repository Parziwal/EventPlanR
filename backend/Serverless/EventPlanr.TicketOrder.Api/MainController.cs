using EventPlanr.Application.Features.Order.Commands;
using EventPlanr.Application.Features.Order.Queries;
using EventPlanr.Application.Models.Order;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventPlanr.TicketOrder.Api;

[ApiController]
[Route("ticketorder")]
public class MainController : ControllerBase
{
    private readonly ISender _sender;

    public MainController(ISender sender)
    {
        _sender = sender;
    }

    [HttpGet("{eventId}")]
    public Task<List<OrderDto>> GetUserEventOrder(Guid eventId)
        => _sender.Send(new GetUserEventOrderQuery
        {
            EventId = eventId,
        });

    [HttpPost("reserve")]
    public Task ReserveUserTickets([FromBody] ReserveUserTicketsCommand command)
        => _sender.Send(command);

    [HttpPost]
    public Task<Guid> OrderReservedTickets([FromBody] OrderReservedTicketsCommand command)
        => _sender.Send(command);
}
