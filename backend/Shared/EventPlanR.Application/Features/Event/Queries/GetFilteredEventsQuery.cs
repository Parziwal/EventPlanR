﻿using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Common;
using EventPlanr.Application.Models.Event;
using EventPlanr.Application.Models.Pagination;
using EventPlanr.Domain.Common;
using EventPlanr.Domain.Enums;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetFilteredEventsQuery : PageWithOrderDto, IRequest<PaginatedListDto<EventDto>>
{
    public string? SearchTerm { get; set; }
    public EventCategory? Category { get; set; }
    public Language? Language { get; set; }
    public Currency? Currency { get; set; }
    public DateTimeOffset? FromDate { get; set; }
    public DateTimeOffset? ToDate { get; set; }
    public LocationDto? Location { get; set; }
}

public class GetFilteredEventsQueryHandler : IRequestHandler<GetFilteredEventsQuery, PaginatedListDto<EventDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;

    public GetFilteredEventsQueryHandler(IApplicationDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<PaginatedListDto<EventDto>> Handle(GetFilteredEventsQuery request, CancellationToken cancellationToken)
    {
        var filteredCoordinates = request.Location != null ? new Coordinates()
        {
            Latitude = request.Location.Latitude,
            Longitude = request.Location.Longitude,
        } : null;

        return await _context.Events
            .AsNoTracking()
            .Where(request.SearchTerm != null, e =>
                e.Name.ToLower().Contains(request.SearchTerm!.ToLower())
                || (e.Description != null && e.Description.ToLower().Contains(request.SearchTerm!.ToLower()))
                || e.Venue.ToLower().Contains(request.SearchTerm!.ToLower()))
            .Where(request.Category != null, e => e.Category == request.Category)
            .Where(request.Language != null, e => e.Language == request.Language)
            .Where(request.Currency != null, e => e.Currency == request.Currency)
            .Where(request.FromDate != null, e => e.FromDate >= request.FromDate)
            .Where(request.ToDate != null, e => e.ToDate <= request.ToDate)
            .Where(request.Location != null, e => e.Coordinates.GetDistance(filteredCoordinates!) < request.Location!.Radius)
            .OrderBy<Domain.Entities.EventEntity, EventDto>(request, _mapper.ConfigurationProvider, e => e.FromDate, OrderDirection.Descending)
            .ProjectTo<EventDto>(_mapper.ConfigurationProvider)
            .ToPaginatedListAsync(request);
    }
}