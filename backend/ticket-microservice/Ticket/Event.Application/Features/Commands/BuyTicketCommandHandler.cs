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
        var soldTickets = new List<SoldTicket>();
        foreach (var ticket in request.tickets)
        {
            soldTickets.Add(new SoldTicket
            {
                EventId = request.eventId,
                Id = Guid.NewGuid().ToString(),
                Quantity = ticket.Quantity,
                TicketName = ticket.TicketName,
                UserId = request.userId,
            });
        }

        var ticketBatch = _dbContext.CreateBatchWrite<SoldTicket>();
        ticketBatch.AddPutItems(soldTickets);
        await ticketBatch.ExecuteAsync(cancellationToken);
    }
}
