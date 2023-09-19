﻿using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Event;
using EventPlanr.Application.Models.Pagination;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetUserInvitationEventsQuery : PageDto, IRequest<PaginatedListDto<EventDto>>
{
    public string? SearchTerm { get; set; }
}

public class GetUserInvitationEventsQueryHandler : IRequestHandler<GetUserInvitationEventsQuery, PaginatedListDto<EventDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly IMapper _mapper;
    private readonly IUserContext _user;

    public GetUserInvitationEventsQueryHandler(IApplicationDbContext context, IMapper mapper, IUserContext user)
    {
        _context = context;
        _mapper = mapper;
        _user = user;
    }

    public async Task<PaginatedListDto<EventDto>> Handle(GetUserInvitationEventsQuery request, CancellationToken cancellationToken)
    {
        return await _context.Events
            .AsNoTracking()
            .Where(e => e.Invitations.Any(i => i.UserEmail == _user.Email))
            .Where(request.SearchTerm != null, e =>
                e.Name.ToLower().Contains(request.SearchTerm!.ToLower())
                || (e.Description != null && e.Description.ToLower().Contains(request.SearchTerm!.ToLower()))
                || e.Venue.ToLower().Contains(request.SearchTerm!.ToLower()))
            .OrderByDescending(i => i.FromDate)
            .ProjectTo<EventDto>(_mapper.ConfigurationProvider)
            .ToPaginatedListAsync(request);
    }
}