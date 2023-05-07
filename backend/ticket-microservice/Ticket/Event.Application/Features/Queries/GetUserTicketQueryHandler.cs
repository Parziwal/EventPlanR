using Amazon.DynamoDBv2.DataModel;
using Amazon.DynamoDBv2.DocumentModel;
using AutoMapper;
using MediatR;
using Ticket.Application.Dto;
using Ticket.Domain.Entities;

namespace Ticket.Application.Features.Queries;

public class GetUserTicketQueryHandler : IRequestHandler<GetUserTicketQuery, List<UserTicketDto>>
{
    private readonly IDynamoDBContext _dbContext;
    private readonly IMapper _mapper;

    public GetUserTicketQueryHandler(IDynamoDBContext dbContext, IMapper mapper)
    {
        _dbContext = dbContext;
        _mapper = mapper;
    }

    public async Task<List<UserTicketDto>> Handle(GetUserTicketQuery request, CancellationToken cancellationToken)
    {
        var userTickets = await _dbContext.ScanAsync<SoldTicket>(
            new List<ScanCondition>() {
                new ScanCondition("EventId", ScanOperator.Equal, request.eventId),
                new ScanCondition("UserId", ScanOperator.Equal, request.userId)
            }).GetRemainingAsync();

        return _mapper.Map<List<UserTicketDto>>(userTickets);
    }
}
