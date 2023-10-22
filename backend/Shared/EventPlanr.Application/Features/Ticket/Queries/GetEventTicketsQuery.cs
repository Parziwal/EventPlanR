using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Models.Ticket;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Ticket.Queries;

public class GetEventTicketsQuery : IRequest<List<TicketDto>>
{
    public Guid EventId { get; set; }
}

public class GetEventTicketsQueryHandler : IRequestHandler<GetEventTicketsQuery, List<TicketDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IMapper _mapper;

    public GetEventTicketsQueryHandler(IApplicationDbContext dbContext, IMapper mapper)
    {
        _dbContext = dbContext;
        _mapper = mapper;
    }

    public async Task<List<TicketDto>> Handle(GetEventTicketsQuery request, CancellationToken cancellationToken)
    {
        return await _dbContext.Tickets
            .Where(t => t.EventId == request.EventId)
            .OrderBy(t => t.Name)
            .ProjectTo<TicketDto>(_mapper.ConfigurationProvider)
            .ToListAsync();
    }
}


