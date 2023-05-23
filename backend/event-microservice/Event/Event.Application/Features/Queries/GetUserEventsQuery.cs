using Event.Application.Dto;
using MediatR;
public record GetUserEventsQuery(string userId) : IRequest<List<EventDto>>;
