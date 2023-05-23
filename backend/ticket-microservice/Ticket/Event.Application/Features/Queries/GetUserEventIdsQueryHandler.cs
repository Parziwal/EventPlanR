using Amazon.DynamoDBv2.DataModel;
using Amazon.DynamoDBv2.DocumentModel;
using AutoMapper;
using MediatR;
using Ticket.Application.Dto;
using Ticket.Application.Features.Queries;
using Ticket.Domain.Entities;

public class GetUserTicketQueryHandler : IRequestHandler<GetUserEventIdsQuery, List<string>>
{
    private readonly IDynamoDBContext _dbContext;

    public GetUserTicketQueryHandler(IDynamoDBContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<List<string>> Handle(GetUserEventIdsQuery request, CancellationToken cancellationToken)
    {
        var tickets = await _dbContext.ScanAsync<SoldTicket>(
            new List<ScanCondition>() {
                new ScanCondition("UserId", ScanOperator.Equal, request.userId)
            }).GetRemainingAsync();

        return tickets.Select(t => t.EventId).Distinct().ToList();
    }
}
