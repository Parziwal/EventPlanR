using MediatR;
using Ticket.Application.Dto;

namespace Ticket.Application.Features.Commands;

public record BuyTicketCommand(string eventId, BuyTicketDto ticket) : IRequest;
