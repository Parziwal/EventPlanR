using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Common;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Common;
using EventPlanr.Domain.Constants;
using EventPlanr.Domain.Enums;
using MediatR;
using NetTopologySuite.Geometries;
using System.Text.Json.Serialization;

namespace EventPlanr.Application.Features.Event.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationEventManage)]
public class EditEventCommand : IRequest
{
    [JsonIgnore]
    public Guid EventId { get; set; }
    public string? Description { get; set; }
    public EventCategory Category { get; set; }
    public DateTimeOffset FromDate { get; set; }
    public DateTimeOffset ToDate { get; set; }
    public string Venue { get; set; } = null!;
    public AddressDto Address { get; set; } = null!;
    public CoordinateDto Coordinate { get; set; } = null!;
}

public class UpdateEventCommandHandler : IRequestHandler<EditEventCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public UpdateEventCommandHandler(IApplicationDbContext dbContext, IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task Handle(EditEventCommand request, CancellationToken cancellationToken)
    {
        var eventEntity = await _dbContext.Events
            .SingleEntityAsync(e => e.Id == request.EventId && e.OrganizationId == _user.OrganizationId);

        if (eventEntity.IsPublished && eventEntity.FromDate <= DateTimeOffset.UtcNow)
        {
            throw new DomainException("InProgressEventCannotBeEdited");
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
        eventEntity.Coordinate = new Point(new Coordinate()
        {
            X = request.Coordinate.Latitude,
            Y = request.Coordinate.Longitude,
        });

        await _dbContext.SaveChangesAsync();
    }
}
