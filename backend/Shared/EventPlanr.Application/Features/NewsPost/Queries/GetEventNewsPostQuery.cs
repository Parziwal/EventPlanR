using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.NewsPost;
using EventPlanr.Application.Models.Pagination;
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
    private readonly IMapper _mapper;

    public GetEventNewsPostQueryHandler(
        IApplicationDbContext dbContext,
        IMapper mapper)
    {
        _dbContext = dbContext;
        _mapper = mapper;
    }

    public async Task<PaginatedListDto<NewsPostDto>> Handle(GetEventNewsPostQuery request, CancellationToken cancellationToken)
    {
        return await _dbContext.NewsPosts
            .Where(np => np.EventId == request.EventId)
            .Where(np => !np.Event.IsPrivate && np.Event.IsPublished)
            .OrderByDescending(np => np.LastModified)
            .ProjectTo<NewsPostDto>(_mapper.ConfigurationProvider)
            .ToPaginatedListAsync(request);
    }
}