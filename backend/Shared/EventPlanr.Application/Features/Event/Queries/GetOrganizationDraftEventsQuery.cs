﻿using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Event;
using EventPlanr.Application.Models.Pagination;
using EventPlanr.Application.Security;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Event.Queries;

[Authorize]
public class GetOrganizationDraftEventsQuery : PageDto, IRequest<PaginatedListDto<OrganizationEventDto>>
{
    public string? SearchTerm { get; set; }
}

public class GetOrganizationDraftEventsQueryHandler : IRequestHandler<GetOrganizationDraftEventsQuery, PaginatedListDto<OrganizationEventDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IMapper _mapper;

    public GetOrganizationDraftEventsQueryHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IMapper mapper)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
    }

    public async Task<PaginatedListDto<OrganizationEventDto>> Handle(GetOrganizationDraftEventsQuery request, CancellationToken cancellationToken)
    {
        return await _dbContext.Events
            .AsNoTracking()
            .Where(e => e.OrganizationId == _user.OrganizationId)
            .Where(e => !e.IsPublished)
            .Where(request.SearchTerm != null, e =>
                e.Name.ToLower().Contains(request.SearchTerm!.ToLower())
                || (e.Description != null && e.Description.ToLower().Contains(request.SearchTerm!.ToLower())))
            .OrderBy(e => e.FromDate)
            .ProjectTo<OrganizationEventDto>(_mapper.ConfigurationProvider)
            .ToPaginatedListAsync(request);
    }
}
