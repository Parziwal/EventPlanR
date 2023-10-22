using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Order;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Order.Queries;

[Authorize(OrganizationPolicy = OrganizationPolicies.EventTicketView)]
public class GetOrgnitationEventOrderDetailsQuery : IRequest<OrderDetailsDto>
{
    public Guid OrderId { get; set; }
}

public class GetOrgnitationEventOrderDetailsQueryHandler : IRequestHandler<GetOrgnitationEventOrderDetailsQuery, OrderDetailsDto>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IMapper _mapper;

    public GetOrgnitationEventOrderDetailsQueryHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IMapper mapper)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
    }

    public async Task<OrderDetailsDto> Handle(GetOrgnitationEventOrderDetailsQuery request, CancellationToken cancellationToken)
    {
        var order = await _dbContext.Orders
            .Include(o => o.SoldTickets)
                .ThenInclude(st => st.Ticket)
            .SingleEntityAsync(o => o.Id == request.OrderId && o.SoldTickets.First().Ticket.Event.OrganizationId == _user.OrganizationId);

        return _mapper.Map<OrderDetailsDto>(order);
    }
}
