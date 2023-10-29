using EventPlanr.Application.Contracts;
using MediatR;

namespace EventPlanr.Application.Features.Order.Commands;

public class DeleteUserExpiredReservedTicketOrderCommand : IRequest
{
    public Guid UserId { get; set; }
}

public class DeleteUserExpiredReservedTicketOrderCommandHandler : IRequestHandler<DeleteUserExpiredReservedTicketOrderCommand>
{
    private readonly ITicketOrderService _ticketService;

    public DeleteUserExpiredReservedTicketOrderCommandHandler(ITicketOrderService ticketService)
    {
        _ticketService = ticketService;
    }

    public async Task Handle(DeleteUserExpiredReservedTicketOrderCommand request, CancellationToken cancellationToken)
    {
        await _ticketService.RemoveUserExpiredTicketAsnyc(request.UserId);
    }
}