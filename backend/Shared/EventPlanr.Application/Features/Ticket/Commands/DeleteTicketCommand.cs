﻿using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using EventPlanr.Domain.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Ticket.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.EventTicketManage)]
public class DeleteTicketCommand : IRequest
{
    public Guid TicketId { get; set; }
}

public class DeleteTicketCommandHandler : IRequestHandler<DeleteTicketCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public DeleteTicketCommandHandler(IApplicationDbContext dbContext, IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task Handle(DeleteTicketCommand request, CancellationToken cancellationToken)
    {
        var ticket = await _dbContext.Tickets
            .Include(t => t.SoldTickets)
            .SingleEntityAsync(t => t.Id == request.TicketId && t.Event.OrganizationId == _user.OrganizationId);

        if (ticket.SoldTickets.Count != 0)
        {
            throw new DomainException("TicketTypeHasSoldTickets");
        }

        _dbContext.Tickets.Remove(ticket);
        await _dbContext.SaveChangesAsync();
    }
}
