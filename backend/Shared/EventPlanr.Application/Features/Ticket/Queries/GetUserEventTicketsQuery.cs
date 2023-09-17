using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Models.Ticket;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Ticket.Queries;

public class GetUserEventTicketsQuery : IRequest<List<SoldTicketDto>>
{
    public Guid EventId { get; set; }
}

public class GetUserEventTicketsQueryHandler : IRequestHandler<GetUserEventTicketsQuery, List<SoldTicketDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;
    private readonly IUserContext _user;

    public GetUserEventTicketsQueryHandler(IApplicationDbContext context, IMapper mapper, IUserContext user)
    {
        _context = context;
        _mapper = mapper;
        _user = user;
    }

    public async Task<List<SoldTicketDto>> Handle(GetUserEventTicketsQuery request, CancellationToken cancellationToken)
    {
        return await _context.SoldTickets
            .Include(st => st.Order)
            .Include(st => st.Ticket)
            .Where(st => st.Ticket.Event.Id == request.EventId)
            .Where(st => st.Order.CustomerUserId == _user.UserId)
            .OrderBy(st => st.Ticket.Name)
            .ProjectTo<SoldTicketDto>(_mapper.ConfigurationProvider)
            .ToListAsync();
    }
}
