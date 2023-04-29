﻿using Event.Application.Dto;
using MediatR;

namespace Event.Application.Features.Queries;

public record GetEventListQuery(EventFilterDto filter) : IRequest<List<EventDto>>;
