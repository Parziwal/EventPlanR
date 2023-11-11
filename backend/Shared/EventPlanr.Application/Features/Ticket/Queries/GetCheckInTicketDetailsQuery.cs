using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Ticket;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Ticket.Queries;

[Authorize(OrganizationPolicy = OrganizationPolicies.UserCheckIn)]
public class GetCheckInTicketDetailsQuery : IRequest<CheckInTicketDetailsDto>
{
    public Guid SoldTicketId { get; set; }
}

public class GetCheckInTicketDetailsQueryHandler : IRequestHandler<GetCheckInTicketDetailsQuery, CheckInTicketDetailsDto>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IMapper _mapper;

    public GetCheckInTicketDetailsQueryHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IMapper mapper)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
    }

    public async Task<CheckInTicketDetailsDto> Handle(GetCheckInTicketDetailsQuery request, CancellationToken cancellationToken)
    {
        var soldTicket = await _dbContext.SoldTickets
            .Include(st => st.Ticket)
            .Include(st => st.Order)
            .SingleEntityAsync(st => st.Id == request.SoldTicketId && st.Ticket.Event.OrganizationId == _user.OrganizationId);

        return _mapper.Map<CheckInTicketDetailsDto>(soldTicket);
    }
}
     