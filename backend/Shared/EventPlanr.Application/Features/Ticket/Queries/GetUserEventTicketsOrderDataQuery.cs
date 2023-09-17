using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Ticket;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Ticket.Queries;

public class GetUserEventTicketsOrderDataQuery : IRequest<List<TicketOrderDto>>
{
    public Guid EventId;
}

public class GetUserEventTicketsOrderDataQueryHandler : IRequestHandler<GetUserEventTicketsOrderDataQuery, List<TicketOrderDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;
    private readonly IUserContext _user;

    public GetUserEventTicketsOrderDataQueryHandler(IApplicationDbContext context, IMapper mapper, IUserContext user)
    {
        _context = context;
        _mapper = mapper;
        _user = user;
    }

    public async Task<List<TicketOrderDto>> Handle(GetUserEventTicketsOrderDataQuery request, CancellationToken cancellationToken)
    {
        return await _context.Orders
            .Include(o => o.SoldTickets)
                .ThenInclude(st => st.Ticket)
            .Where(o => o.CustomerUserId == _user.UserId)
            .Where(o => o.SoldTickets.First().Ticket.Event.Id == request.EventId)
            .ProjectTo<TicketOrderDto>(_mapper.ConfigurationProvider)
            .ToListAsync();
    }
}
