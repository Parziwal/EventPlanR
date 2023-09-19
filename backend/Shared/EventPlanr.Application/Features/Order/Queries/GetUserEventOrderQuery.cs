using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Order;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Order.Queries;

public class GetUserEventOrderQuery : IRequest<List<OrderDto>>
{
    public Guid EventId;
}

public class GetUserEventOrderQueryHandler : IRequestHandler<GetUserEventOrderQuery, List<OrderDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;
    private readonly IUserContext _user;

    public GetUserEventOrderQueryHandler(IApplicationDbContext context, IMapper mapper, IUserContext user)
    {
        _context = context;
        _mapper = mapper;
        _user = user;
    }

    public async Task<List<OrderDto>> Handle(GetUserEventOrderQuery request, CancellationToken cancellationToken)
    {
        return await _context.Orders
            .Include(o => o.SoldTickets)
                .ThenInclude(st => st.Ticket)
            .Where(o => o.CustomerUserId == _user.UserId)
            .Where(o => o.SoldTickets.First().Ticket.Event.Id == request.EventId)
            .ProjectTo<OrderDto>(_mapper.ConfigurationProvider)
            .ToListAsync();
    }
}
