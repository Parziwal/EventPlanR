using MediatR;
using Ticket.Application.Dto;

namespace Ticket.Application.Features.Queries;

public record GetEventTicketsQuery(string eventId) : IRequest<List<EventTicketDto>>;
