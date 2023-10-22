using EventPlanr.Application.Contracts;
using EventPlanr.Application.Models.Common;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Common;
using EventPlanr.Domain.Constants;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Enums;
using MediatR;

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
    public CoordinatesDto Coordinates { get; set; } = null!;
    public Currency Currency { get; set; }
    public bool IsPrivate { get; set; }
}

public class CreateEventCommandHandler : IRequestHandler<CreateEventCommand, Guid>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public CreateEventCommandHandler(IApplicationDbContext dbContext, IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task<Guid> Handle(CreateEventCommand request, CancellationToken cancellationToken)
    {
        var createdEvent = new EventEntity()
        {
            Name = request.Name,
            Description = request.Description,
            Category = request.Category,
            FromDate = request.FromDate,
            ToDate = request.ToDate,
            Venue = request.Venue,
            Address = new Address()
            {
                Country = request.Address.Country,
                ZipCode = request.Address.ZipCode,
                City = request.Address.City,
                AddressLine = request.Address.AddressLine,
            },
            Coordinates = new Coordinates()
            {
                Latitude = request.Coordinates.Latitude,
                Longitude = request.Coordinates.Longitude,
            },
            Currency = request.Currency,
            IsPrivate = request.IsPrivate,
            IsPublished = false,
            OrganizationId = (Guid)_user.OrganizationId!,
        };

        _dbContext.Events.Add(createdEvent);
        await _dbContext.SaveChangesAsync();

        return createdEvent.Id;
    }
}