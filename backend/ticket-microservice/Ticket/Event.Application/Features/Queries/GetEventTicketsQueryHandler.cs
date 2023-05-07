using Amazon.DynamoDBv2.DataModel;
using AutoMapper;
using MediatR;
using Ticket.Application.Dto;
using Ticket.Domain.Entities;

namespace Ticket.Application.Features.Queries;

public class GetEventTicketsQueryHandler : IRequestHandler<GetEventTicketsQuery, List<EventTicketDto>>
{
    private readonly IDynamoDBContext _dbContext;
    private readonly IMapper _mapper;

    public GetEventTicketsQueryHandler(IDynamoDBContext dbContext, IMapper mapper)
    {
        _dbContext = dbContext;
        _mapper = mapper;
    }

    public async Task<List<EventTicketDto>> Handle(GetEventTicketsQuery request, CancellationToken cancellationToken)
    {
        var tickets = await _dbContext.QueryAsync<EventTicket>(request.eventId).GetRemainingAsync();
        return _mapper.Map<List<EventTicketDto>>(tickets);
    }
}
