using AutoMapper;
using AutoMapper.Execution;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Chat;
using EventPlanr.Application.Models.User;
using EventPlanr.Domain.Entities;
using MediatR;

namespace EventPlanr.Application.Features.Chat.Commands;
public class CreateChatMessageCommand : IRequest<ChatMessageDto>
{
    public Guid ChatId { get; set; }
    public Guid UserId { get; set; }
    public string Content { get; set; } = null!;
}

public class CreateChatMessageCommandHandler : IRequestHandler<CreateChatMessageCommand, ChatMessageDto>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IChatService _chatService;
    private readonly IMapper _mapper;
    private readonly IUserService _userService;

    public CreateChatMessageCommandHandler(
        IApplicationDbContext dbContext,
        IChatService chatService,
        IMapper mapper,
        IUserService userService)
    {
        _dbContext = dbContext;
        _chatService = chatService;
        _mapper = mapper;
        _userService = userService;
    }

    public async Task<ChatMessageDto> Handle(CreateChatMessageCommand request, CancellationToken cancellationToken)
    {
        var timeNow = DateTimeOffset.UtcNow;
        var message = new ChatMessageEntity()
        { 
            ChatId = request.ChatId,
            Content = request.Content,
            CreatedAt = timeNow,
            SenderId = request.UserId,
        };

        await _chatService.AddMessageToChat(message);

        var chat = await _dbContext.Chats
            .SingleEntityAsync(c => c.Id == request.ChatId);

        chat.LastMessageDate = timeNow;

        await _dbContext.SaveChangesAsync();

        var mappedMessage = _mapper.Map<ChatMessageDto>(message);
        var sender = await _userService.GetUserById(mappedMessage.Sender.Id);
        mappedMessage.Sender = _mapper.Map<UserDto>(sender);
        return mappedMessage;
    }
}