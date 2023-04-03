using Event.Application.Dto;
using MediatR;

namespace Event.Application.Features.Queries;

public record GetEventListQuery : IRequest<List<EventDto>>;
