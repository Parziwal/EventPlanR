using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Repository;
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
    private readonly ITimeRepository _timeRepository;

    public SetChatMessagesReadCommandHandler(
        IApplicationDbContext dbContext,
        IUserContext user,
        ITimeRepository timeRepository)
    {
        _dbContext = dbContext;
        _user = user;
        _timeRepository = timeRepository;
    }

    public async Task Handle(SetChatMessagesReadCommand request, CancellationToken cancellationToken)
    {
        var chatMember = await _dbContext.ChatMembers
            .SingleEntityAsync(cm => cm.MemberUserId == _user.UserId && cm.ChatId == request.ChatId);
        chatMember.LastSeen = _timeRepository.GetCurrentUtcTime();
        
        await _dbContext.SaveChangesAsync();
    }
}
