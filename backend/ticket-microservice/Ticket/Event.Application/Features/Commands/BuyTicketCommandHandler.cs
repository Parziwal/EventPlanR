using Amazon.DynamoDBv2.DataModel;
using MediatR;
using Ticket.Domain.Entities;

namespace Ticket.Application.Features.Commands;

public class BuyTicketCommandHandler : IRequestHandler<BuyTicketCommand>
{
    private readonly IDynamoDBContext _dbContext;

    public BuyTicketCommandHandler(IDynamoDBContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task Handle(BuyTicketCommand request, CancellationToken cancellationToken)
    {
        var soldTicket = new SoldTicket
        {
            EventId = request.eventId,
            Id = Guid.NewGuid().ToString(),
            Quantity = request.ticket.Quantity,
            TicketName = request.ticket.TicketName,
            UserId = request.ticket.UserId,
        };
        await _dbContext.SaveAsync(soldTicket, cancellationToken);
    }
}
