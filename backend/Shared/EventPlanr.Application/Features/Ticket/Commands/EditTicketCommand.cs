using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;
using Microsoft.EntityFrameworkCore;
using System.Text.Json.Serialization;

namespace EventPlanr.Application.Features.Ticket.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.EventTicketManage)]
public class EditTicketCommand : IRequest
{
    [JsonIgnore]
    public Guid TicketId { get; set; }
    public double Price { get; set; }
    public int Count { get; set; }
    public string? Description { get; set; }
    public DateTimeOffset SaleStarts { get; set; }
    public DateTimeOffset SaleEnds { get; set; }
}

public class EditTicketCommandHandler : IRequestHandler<EditTicketCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public EditTicketCommandHandler(IApplicationDbContext dbContext, IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task Handle(EditTicketCommand request, CancellationToken cancellationToken)
    {
        var ticket = await _dbContext.Tickets
            .Include(t => t.Event)
            .Include(t => t.SoldTickets)
            .SingleEntityAsync(t => t.Id == request.TicketId && t.Event.OrganizationId == _user.OrganizationId);

        if (ticket.Event.ToDate < request.SaleEnds)
        {
            throw new DomainException("TicketSaleDatesMustBeBeforeEventDateException");
        }

        ticket.Price = request.Price;
        ticket.Count = request.Count < ticket.SoldTickets.Count() ? ticket.SoldTickets.Count() : request.Count;
        ticket.Description = request.Description;
        ticket.SaleStarts = request.SaleStarts;
        ticket.SaleEnds = request.SaleEnds;
        ticket.RemainingCount = ticket.Count - ticket.SoldTickets.Count();

        await _dbContext.SaveChangesAsync();
    }
}