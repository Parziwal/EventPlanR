using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Order;
using EventPlanr.Application.Models.Pagination;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;
using Microsoft.EntityFrameworkCore;
using System.Text.Json.Serialization;

namespace EventPlanr.Application.Features.Order.Queries;

[Authorize(OrganizationPolicy = OrganizationPolicies.EventTicketView)]
public class GetOrganizationEventOrdersQuery : PageDto, IRequest<PaginatedListDto<EventOrderDto>>
{
    [JsonIgnore]
    public Guid EventId { get; set; }
}

public class GetOrganizationEventOrdersQueryHandler : IRequestHandler<GetOrganizationEventOrdersQuery, PaginatedListDto<EventOrderDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IMapper _mapper;

    public GetOrganizationEventOrdersQueryHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IMapper mapper)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
    }

    public async Task<PaginatedListDto<EventOrderDto>> Handle(GetOrganizationEventOrdersQuery request, CancellationToken cancellationToken)
    {
        return await _dbContext.Orders
            .Include(o => o.SoldTickets)
            .Where(o => o.SoldTickets.First().Ticket.EventId == request.EventId)
            .Where(o => o.SoldTickets.First().Ticket.Event.OrganizationId == _user.OrganizationId)
            .OrderByDescending(o => o.Created)
            .ProjectTo<EventOrderDto>(_mapper.ConfigurationProvider)
            .ToPaginatedListAsync(request);
    }
}