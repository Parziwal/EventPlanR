using EventPlanr.Application.Contracts;
using EventPlanr.Application.Models.Common;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Common;
using EventPlanr.Domain.Constants;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Enums;
using EventPlanr.Domain.Repository;
using MediatR;
using NetTopologySuite.Geometries;

namespace EventPlanr.Application.Features.Event.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationEventManage)]
public class CreateEventCommand : IRequest<Guid>
{
    public string Name { get; set; } = null!;
    public string? Description { get; set; }
    public EventCategory Category { get; set; }
    public DateTimeOffset FromDate { get; set; }
    public DateTimeOffset ToDate { get; set; }
    public string Venue { get; set; } = null!;
    public AddressDto Address { get; set; } = null!;
    public CoordinateDto Coordinate { get; set; } = null!;
    public Currency Currency { get; set; }
    public bool IsPrivate { get; set; }
}

public class CreateEventCommandHandler : IRequestHandler<CreateEventCommand, Guid>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly ITimeRepository _timeRepository;

    public CreateEventCommandHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        ITimeRepository timeRepository)
    {
        _dbContext = dbContext;
        _user = user;
        _timeRepository = timeRepository;
    }

    public async Task<Guid> Handle(CreateEventCommand request, CancellationToken cancellationToken)
    {
        var timeNow = _timeRepository.GetCurrentUtcTime();
        var createdEvent = new EventEntity()
        {
            Name = request.Name,
            Description = request.Description,
            Category = request.Category,
            FromDate = request.FromDate.ToUniversalTime(),
            ToDate = request.ToDate.ToUniversalTime(),
            Venue = request.Venue,
            Address = new Address()
            {
                Country = request.Address.Country,
                ZipCode = request.Address.ZipCode,
                City = request.Address.City,
                AddressLine = request.Address.AddressLine,
            },
            Coordinate = new Point(new Coordinate()
            {
                X = request.Coordinate.Latitude,
                Y = request.Coordinate.Longitude,
            }),
            Currency = request.Currency,
            IsPrivate = request.IsPrivate,
            IsPublished = request.IsPrivate,
            OrganizationId = (Guid)_user.OrganizationId!,
            Chat = new ChatEntity()
            {
                LastMessageDate = timeNow,
            },
        };
        var invitationTicket = new TicketEntity()
        {
            Name = "INVITATION_TICKET",
            Price = 0,
            Count = 0,
            RemainingCount = 0,
            SaleStarts = timeNow,
            SaleEnds = timeNow,
            Event = createdEvent,
        };

        _dbContext.Events.Add(createdEvent);
        _dbContext.Tickets.Add(invitationTicket);
        await _dbContext.SaveChangesAsync();

        createdEvent.InvitationTicketId = invitationTicket.Id;
        await _dbContext.SaveChangesAsync();

        return createdEvent.Id;
    }
}