using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Models.Ticket;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Ticket.Queries;

[Authorize(OrganizationPolicy = OrganizationPolicies.EventTicketView)]
public class GetOrganizationEventTicketsQuery : IRequest<List<OrganizationTicketDto>>
{
    public Guid EventId { get; set; }
}

public class GetOrganizationEventTicketsQueryHandler : IRequestHandler<GetOrganizationEventTicketsQuery, List<OrganizationTicketDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IMapper _mapper;

    public GetOrganizationEventTicketsQueryHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IMapper mapper)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
    }

    public async Task<List<OrganizationTicketDto>> Handle(GetOrganizationEventTicketsQuery request, CancellationToken cancellationToken)
    {
        return await _dbContext.Tickets
            .Where(t => t.EventId == request.EventId && t.Event.OrganizationId == _user.OrganizationId)
            .OrderBy(t => t.Name)
            .ProjectTo<OrganizationTicketDto>(_mapper.ConfigurationProvider)
            .ToListAsync();
    }
}