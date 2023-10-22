using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.NewsPost;
using EventPlanr.Application.Models.Pagination;
using EventPlanr.Domain.Constants;
using MediatR;
using System.Text.Json.Serialization;

namespace EventPlanr.Application.Features.NewsPost.Queries;

public class GetEventNewsPostQuery : PageDto, IRequest<PaginatedListDto<NewsPostDto>>
{
    [JsonIgnore]
    public Guid EventId { get; set; }
}

public class GetEventNewsPostQueryHandler : IRequestHandler<GetEventNewsPostQuery, PaginatedListDto<NewsPostDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IMapper _mapper;

    public GetEventNewsPostQueryHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IMapper mapper)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
    }


    public async Task<PaginatedListDto<NewsPostDto>> Handle(GetEventNewsPostQuery request, CancellationToken cancellationToken)
    {
        var eventEntity = await _dbContext.Events
            .SingleEntityAsync(e => e.Id == request.EventId);

        if (!eventEntity.IsPublished
            && (eventEntity.OrganizationId != _user.OrganizationId
            || _user.OrganizationPolicies.Contains(OrganizationPolicies.NewsPostView)))
        {
            throw new ForbiddenException();
        }

        return await _dbContext.NewsPosts
            .Where(np => np.EventId == request.EventId)
            .OrderByDescending(np => np.LastModified)
            .ProjectTo<NewsPostDto>(_mapper.ConfigurationProvider)
            .ToPaginatedListAsync(request);
    }
}