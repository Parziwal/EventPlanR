using MediatR;
using Ticket.Application.Dto;

namespace Ticket.Application.Features.Queries;

public record GetUserTicketQuery(string eventId, string userId) : IRequest<List<UserTicketDto>>;
