using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Models.Ticket;
using EventPlanr.Domain.Repository;
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
    private readonly ITimeRepository _timeRepository;

    public GetEventTicketsQueryHandler(
        IApplicationDbContext dbContext,
        IMapper mapper,
        ITimeRepository timeRepository)
    {
        _dbContext = dbContext;
        _mapper = mapper;
        _timeRepository = timeRepository;
    }

    public async Task<List<TicketDto>> Handle(GetEventTicketsQuery request, CancellationToken cancellationToken)
    {
        var timeNow = _timeRepository.GetCurrentUtcTime();

        return await _dbContext.Tickets
            .AsNoTracking()
            .Where(t => t.EventId == request.EventId)
            .Where(t => t.Event.IsPublished && !t.Event.IsPrivate)
            .Where(t => timeNow >= t.SaleStarts && timeNow <= t.SaleEnds)
            .OrderBy(t => t.Name)
            .ProjectTo<TicketDto>(_mapper.ConfigurationProvider)
            .ToListAsync();
    }
}


