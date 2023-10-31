using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Models.Chat;
using MediatR;

namespace EventPlanr.Application.Features.Chat.Queries;

public class GetChatMessagesQuery : IRequest<List<ChatMessageDto>>
{
    public Guid ChatId { get; set; }
}

public class GetChatMessagesQueryHandler : IRequestHandler<GetChatMessagesQuery, List<ChatMessageDto>>
{
    private readonly IChatService _chatService;
    private readonly IMapper _mapper;

    public GetChatMessagesQueryHandler(IChatService chatService, IMapper mapper)
    {
        _chatService = chatService;
        _mapper = mapper;
    }

    public async Task<List<ChatMessageDto>> Handle(GetChatMessagesQuery request, CancellationToken cancellationToken)
    {
        var messages = await _chatService.GetChatMessagesAsync(request.ChatId);
        return _mapper.Map<List<ChatMessageDto>>(messages);
    }
}