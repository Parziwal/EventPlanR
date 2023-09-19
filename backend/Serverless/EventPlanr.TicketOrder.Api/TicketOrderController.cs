using EventPlanr.Application.Features.Order.Commands;
using EventPlanr.Application.Features.Order.Queries;
using EventPlanr.Application.Models.Order;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventPlanr.TicketOrder.Api;

[ApiController]
[Route("[controller]")]
public class TicketOrderController : ControllerBase
{
    private readonly ISender _sender;

    public TicketOrderController(ISender sender)
    {
        _sender = sender;
    }

    [HttpGet("/{eventId}")]
    public Task<List<OrderDto>> GetUserEventTicketsOrderData(Guid eventId)
        => _sender.Send(new GetUserEventOrderQuery
        {
            EventId = eventId,
        });

    [HttpPost("/reserve")]
    public Task GetUserEventTicketsOrderData([FromBody] ReserveUserTicketsCommand command)
        => _sender.Send(command);

    [HttpPost]
    public Task<Guid> GetUserEventTicketsOrderData([FromBody] OrderReservedTicketsCommand command)
        => _sender.Send(command);
}
