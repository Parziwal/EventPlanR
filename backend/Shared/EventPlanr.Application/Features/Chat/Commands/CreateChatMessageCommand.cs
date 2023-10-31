using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Models.Chat;
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
    private readonly IChatService _chatService;
    private readonly IMapper _mapper;

    public CreateChatMessageCommandHandler(IChatService chatService, IMapper mapper)
    {
        _chatService = chatService;
        _mapper = mapper;
    }

    public async Task<ChatMessageDto> Handle(CreateChatMessageCommand request, CancellationToken cancellationToken)
    {
        var message = new ChatMessageEntity()
        { 
            ChatId = request.ChatId,
            Content = request.Content,
            CreatedAt = DateTimeOffset.UtcNow,
            SenderId = request.UserId,
        };

        await _chatService.AddMessageToChat(message);

        return _mapper.Map<ChatMessageDto>(message);
    }
}