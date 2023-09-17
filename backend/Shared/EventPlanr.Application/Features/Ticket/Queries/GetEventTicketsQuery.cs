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
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;

    public GetEventTicketsQueryHandler(IApplicationDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<List<TicketDto>> Handle(GetEventTicketsQuery request, CancellationToken cancellationToken)
    {
        return await _context.Tickets
            .Where(t => t.EventId == request.EventId)
            .ProjectTo<TicketDto>(_mapper.ConfigurationProvider)
            .ToListAsync();
    }
}


