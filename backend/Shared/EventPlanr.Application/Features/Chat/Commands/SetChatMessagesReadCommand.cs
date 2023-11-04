using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using MediatR;

namespace EventPlanr.Application.Features.Chat.Commands;

[Authorize]
public class SetChatMessagesReadCommand : IRequest
{
    public Guid ChatId { get; set; }
}

public class SetChatMessagesReadCommandHandler : IRequestHandler<SetChatMessagesReadCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public SetChatMessagesReadCommandHandler(IApplicationDbContext dbContext, IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task Handle(SetChatMessagesReadCommand request, CancellationToken cancellationToken)
    {
        var chatMember = await _dbContext.ChatMembers
            .SingleEntityAsync(cm => cm.MemberUserId == _user.UserId && cm.ChatId == request.ChatId);
        chatMember.LastSeen = DateTimeOffset.UtcNow;
        
        await _dbContext.SaveChangesAsync();
    }
}
