using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Ticket;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using EventPlanr.Domain.Repository;
using MediatR;
using Microsoft.EntityFrameworkCore;
using System.Text.Json.Serialization;

namespace EventPlanr.Application.Features.Ticket.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.UserCheckIn)]
public class TicketCheckInCommand : IRequest<CheckInTicketDto>
{
    [JsonIgnore]
    public Guid SoldTicketId { get; set; }
    public bool CheckIn { get; set; }
}

public class TicketCheckInCommandHandler : IRequestHandler<TicketCheckInCommand, CheckInTicketDto>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IMapper _mapper;
    private readonly ITimeRepository _timeRepository;

    public TicketCheckInCommandHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IMapper mapper,
        ITimeRepository timeRepository)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
        _timeRepository = timeRepository;
    }

    public async Task<CheckInTicketDto> Handle(TicketCheckInCommand request, CancellationToken cancellationToken)
    {
        var soldTicket = await _dbContext.SoldTickets
            .Include(st => st.Ticket)
            .SingleEntityAsync(st => st.Id == request.SoldTicketId && st.Ticket.Event.OrganizationId == _user.OrganizationId);

        if (soldTicket.IsCheckedIn && request.CheckIn)
        {
            throw new DomainException("UserAlreadyCheckedIn");
        }

        soldTicket.IsCheckedIn = request.CheckIn;
        soldTicket.CheckInDate = request.CheckIn ? _timeRepository.GetCurrentUtcTime() : null;
        await _dbContext.SaveChangesAsync();

        return _mapper.Map<CheckInTicketDto>(soldTicket);
    }
}
