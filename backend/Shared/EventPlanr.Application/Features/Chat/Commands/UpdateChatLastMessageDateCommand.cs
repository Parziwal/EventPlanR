using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using MediatR;

namespace EventPlanr.Application.Features.Chat.Commands;
public class UpdateChatLastMessageDateCommand : IRequest
{
    public Guid ChatId { get; set; }
    public DateTimeOffset MessageDate { get; set; }
}

public class UpdateChatLastMessageDateCommandHandler : IRequestHandler<UpdateChatLastMessageDateCommand>
{
    private IApplicationDbContext _dbContext;

    public UpdateChatLastMessageDateCommandHandler(IApplicationDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task Handle(UpdateChatLastMessageDateCommand request, CancellationToken cancellationToken)
    {
        var chat = await _dbContext.Chats
            .SingleEntityAsync(c => c.Id == request.ChatId);

        chat.LastMessageDate = request.MessageDate;

        await _dbContext.SaveChangesAsync();
    }
}
