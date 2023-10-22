using EventPlanr.Application.Features.Order.Commands;
using EventPlanr.Application.Features.Order.Queries;
using EventPlanr.Application.Models.Order;
using EventPlanr.Application.Models.Pagination;
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
    public Task<List<OrderDetailsDto>> GetUserEventOrder(Guid eventId)
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

    [HttpGet("organization/{eventId}")]
    public Task<PaginatedListDto<EventOrderDto>> GetOrganizationEventOrders(Guid eventId, [FromQuery] GetOrganizationEventOrdersQuery query)
    {
        query.EventId = eventId;
        return _sender.Send(query);
    }

    [HttpGet("organization/order/{orderId}")]
    public Task<OrderDetailsDto> GetOrganizationEventOrderDetails(Guid orderId)
        => _sender.Send(new GetOrgnitationEventOrderDetailsQuery()
        {
            OrderId = orderId,
        });

    [HttpPost("organization/order/refund/{orderId}")]
    public Task RefundOrderTickets(Guid orderId)
        => _sender.Send(new RefundOrderTicketsCommand()
        {
            OrderId = orderId,
        });
}
