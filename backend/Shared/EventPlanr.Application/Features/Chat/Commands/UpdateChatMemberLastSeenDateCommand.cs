using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using MediatR;

namespace EventPlanr.Application.Features.Chat.Commands;

public class UpdateChatMemberLastSeenDateCommand : IRequest
{
    public Guid UserId { get; set; }
    public Guid ChatId { get; set; }
    public DateTime LastSeenDate { get; set; }
}

public class UpdateChatMemberLastSeenDateCommandHandler : IRequestHandler<UpdateChatMemberLastSeenDateCommand>
{
    private readonly IApplicationDbContext _dbContext;

    public UpdateChatMemberLastSeenDateCommandHandler(IApplicationDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task Handle(UpdateChatMemberLastSeenDateCommand request, CancellationToken cancellationToken)
    {
        var chatMember = await _dbContext.ChatMembers
            .SingleEntityAsync(cm => cm.Id == request.ChatId && cm.MemberUserId == request.UserId);

        chatMember.LastSeen = request.LastSeenDate;

        await _dbContext.SaveChangesAsync();
    }
}
