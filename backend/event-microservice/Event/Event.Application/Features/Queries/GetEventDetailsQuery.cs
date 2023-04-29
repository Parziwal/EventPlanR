using Event.Application.Dto;
using MediatR;

namespace Event.Application.Features.Queries;

public record GetEventDetailsQuery(Guid eventId) : IRequest<EventDetailsDto>;