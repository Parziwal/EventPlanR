using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.NewsPost;
using EventPlanr.Application.Models.Pagination;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;
using System.Text.Json.Serialization;

namespace EventPlanr.Application.Features.NewsPost.Queries;

[Authorize(OrganizationPolicy = OrganizationPolicies.NewsPostView)]
public class GetOrganizationEventNewsPostQuery : PageDto, IRequest<PaginatedListDto<OrganizationNewsPostDto>>
{
    [JsonIgnore]
    public Guid EventId { get; set; }
}

public class GetOrganizationEventNewsPostQueryHandler : IRequestHandler<GetOrganizationEventNewsPostQuery, PaginatedListDto<OrganizationNewsPostDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IMapper _mapper;

    public GetOrganizationEventNewsPostQueryHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        IMapper mapper)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
    }


    public async Task<PaginatedListDto<OrganizationNewsPostDto>> Handle(GetOrganizationEventNewsPostQuery request, CancellationToken cancellationToken)
    {
        return await _dbContext.NewsPosts
            .Where(np => np.EventId == request.EventId && np.Event.OrganizationId == _user.OrganizationId)
            .OrderByDescending(np => np.LastModified)
            .ProjectTo<OrganizationNewsPostDto>(_mapper.ConfigurationProvider)
            .ToPaginatedListAsync(request);
    }
}