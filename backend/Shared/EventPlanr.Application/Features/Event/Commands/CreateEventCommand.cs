using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Models.Common;
using EventPlanr.Domain.Common;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Enums;
using MediatR;

namespace EventPlanr.Application.Features.Event.Commands;

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
    public Language Language { get; set; }
    public Currency Currency { get; set; }
    public bool IsPrivate { get; set; }
    public Guid OrganizationId { get; set; }
}

public class CreateEventCommandHandler : IRequestHandler<CreateEventCommand, Guid>
{
    private readonly IApplicationDbContext _context;
    private readonly IUserContext _user;

    public CreateEventCommandHandler(IApplicationDbContext context, IUserContext user)
    {
        _context = context;
        _user = user;
    }

    public async Task<Guid> Handle(CreateEventCommand request, CancellationToken cancellationToken)
    {
        if (!_user.OrganizationIds.Contains(request.OrganizationId.ToString()))
        {
            throw new UserNotBelongToOrganizationException(_user.UserId, request.OrganizationId.ToString());
        }

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
            Language = request.Language,
            Currency = request.Currency,
            IsPrivate = request.IsPrivate,
            IsPublished = false,
            OrganizationId = request.OrganizationId,
        };

        _context.Events.Add(createdEvent);
        await _context.SaveChangesAsync();

        return createdEvent.Id;
    }
}