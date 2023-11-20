using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using EventPlanr.Domain.Entities;
using MediatR;
using System.Text.Json.Serialization;

namespace EventPlanr.Application.Features.Ticket.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.EventTicketManage)]
public class AddTicketToEventCommand : IRequest<Guid>
{
    [JsonIgnore]
    public Guid EventId { get; set; }
    public string Name { get; set; } = null!;
    public double Price { get; set; }
    public int Count { get; set; }
    public string? Description { get; set; }
    public DateTimeOffset SaleStarts { get; set; }
    public DateTimeOffset SaleEnds { get; set; }
}

public class AddTicketToEventCommandHandler : IRequestHandler<AddTicketToEventCommand, Guid>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public AddTicketToEventCommandHandler(IApplicationDbContext context, IUserContext user)
    {
        _dbContext = context;
        _user = user;
    }

    public async Task<Guid> Handle(AddTicketToEventCommand request, CancellationToken cancellationToken)
    {
        var eventEntity = await _dbContext.Events
            .SingleEntityAsync(e => e.Id == request.EventId && e.OrganizationId == _user.OrganizationId);

        if (eventEntity.IsPrivate)
        {
            throw new DomainException("PrivateEventHasNoTicketOptions");
        }

        if (eventEntity.ToDate < request.SaleEnds)
        {
            throw new DomainException("TicketSaleDatesMustBeBeforeEventToDate");
        }

        var ticket = new TicketEntity()
        {
            Name = request.Name,
            Price = request.Price,
            Count = request.Count,
            RemainingCount = request.Count,
            Description = request.Description,
            SaleStarts = request.SaleStarts,
            SaleEnds = request.SaleEnds,
            Event = eventEntity,
        };

        _dbContext.Tickets.Add(ticket);
        await _dbContext.SaveChangesAsync();

        return ticket.Id;
    }
}
