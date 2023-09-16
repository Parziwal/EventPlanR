using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Common;
using EventPlanr.Domain.Common;
using EventPlanr.Domain.Enums;
using MediatR;

namespace EventPlanr.Application.Features.Event.Commands;

public class UpdateEventCommand : IRequest
{
    public Guid EventId { get; set; }
    public string? Description { get; set; }
    public EventCategory Category { get; set; }
    public DateTimeOffset FromDate { get; set; }
    public DateTimeOffset ToDate { get; set; }
    public string Venue { get; set; } = null!;
    public AddressDto Address { get; set; } = null!;
    public CoordinatesDto Coordinates { get; set; } = null!;
    public Language Language { get; set; }
    public Currency Currency { get; set; }
    public bool IsPrivate { get; set; }
}

public class UpdateEventCommandHandler : IRequestHandler<UpdateEventCommand>
{
    private readonly IApplicationDbContext _context;
    private readonly IUserContext _user;

    public UpdateEventCommandHandler(IApplicationDbContext context, IUserContext user)
    {
        _context = context;
        _user = user;
    }

    public async Task Handle(UpdateEventCommand request, CancellationToken cancellationToken)
    {
        var eventEntity = await _context.Events
            .SingleEntityAsync(e => e.Id == request.EventId, request.EventId);

        if (!_user.OrganizationIds.Contains(eventEntity.OrganizationId.ToString()))
        {
            throw new UserNotBelongToOrganizationException(_user.UserId, eventEntity.OrganizationId.ToString());
        }

        eventEntity.Description = request.Description;
        eventEntity.Category = request.Category;
        eventEntity.FromDate = request.FromDate;
        eventEntity.ToDate = request.ToDate;
        eventEntity.Venue = request.Venue;
        eventEntity.Address = new Address()
        {
            Country = request.Address.Country,
            ZipCode = request.Address.ZipCode,
            City = request.Address.City,
            AddressLine = request.Address.AddressLine,
        };
        eventEntity.Coordinates = new Coordinates()
        {
            Latitude = request.Coordinates.Latitude,
            Longitude = request.Coordinates.Longitude,
        };
        eventEntity.Language = request.Language;
        eventEntity.Currency = request.Currency;
        eventEntity.IsPrivate = request.IsPrivate;

        await _context.SaveChangesAsync();
    }
}
