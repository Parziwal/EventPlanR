using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Pagination;
using EventPlanr.Application.Models.Ticket;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;

namespace EventPlanr.Application.Features.Ticket.Queries;

[Authorize(OrganizationPolicy = OrganizationPolicies.UserCheckIn)]
public class GetOrganizationEvenCheckInTicketsQuery : PageDto, IRequest<PaginatedListDto<CheckInTicketDto>>
{
    public Guid EventId { get; set; }
}

public class GetOrganizationEvenCheckInTicketsQueryHandler : IRequestHandler<GetOrganizationEvenCheckInTicketsQuery, PaginatedListDto<CheckInTicketDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IMapper _mapper;

    public GetOrganizationEvenCheckInTicketsQueryHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IMapper mapper)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
    }

    public async Task<PaginatedListDto<CheckInTicketDto>> Handle(GetOrganizationEvenCheckInTicketsQuery request, CancellationToken cancellationToken)
    {
        return await _dbContext.SoldTickets
            .Where(st => st.Ticket.EventId == request.EventId && st.Ticket.Event.OrganizationId == _user.OrganizationId)
            .OrderBy(st => st.UserFirstName)
                .ThenBy(st => st.UserLastName)
            .ProjectTo<CheckInTicketDto>(_mapper.ConfigurationProvider)
            .ToPaginatedListAsync(request);
    }
}
