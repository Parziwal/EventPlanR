using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Order;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Order.Queries;

public class GetUserEventOrderQuery : IRequest<List<OrderDetailsDto>>
{
    public Guid EventId;
}

public class GetUserEventOrderQueryHandler : IRequestHandler<GetUserEventOrderQuery, List<OrderDetailsDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IMapper _mapper;
    private readonly IUserContext _user;

    public GetUserEventOrderQueryHandler(IApplicationDbContext dbContext, IMapper mapper, IUserContext user)
    {
        _dbContext = dbContext;
        _mapper = mapper;
        _user = user;
    }

    public async Task<List<OrderDetailsDto>> Handle(GetUserEventOrderQuery request, CancellationToken cancellationToken)
    {
        return await _dbContext.Orders
            .IgnoreQueryFilters()
            .Include(o => o.SoldTickets)
                .ThenInclude(st => st.Ticket)
            .Where(o => o.CustomerUserId == _user.UserId)
            .Where(o => o.SoldTickets.First().Ticket.EventId == request.EventId)
            .OrderByDescending(o => o.Created)
            .ProjectTo<OrderDetailsDto>(_mapper.ConfigurationProvider)
            .ToListAsync();
    }
}
