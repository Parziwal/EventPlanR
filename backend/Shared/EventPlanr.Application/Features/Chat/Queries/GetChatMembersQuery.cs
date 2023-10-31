using EventPlanr.Application.Contracts;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Chat.Queries;

public class GetChatMembersQuery : IRequest<List<Guid>>
{
    public Guid ChatId { get; set; }
}

public class GetChatMembersQueryHandler : IRequestHandler<GetChatMembersQuery, List<Guid>>
{
    private readonly IApplicationDbContext _dbContext;

    public GetChatMembersQueryHandler(IApplicationDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<List<Guid>> Handle(GetChatMembersQuery request, CancellationToken cancellationToken)
    {
        return await _dbContext.ChatMembers
            .Where(cm => cm.ChatId == request.ChatId)
            .Select(cm => cm.ChatId)
            .ToListAsync();
    }
}
