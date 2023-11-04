using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Models.Chat;
using EventPlanr.Application.Models.User;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Chat.Queries;

public class GetChatMessagesQuery : IRequest<List<ChatMessageDto>>
{
    public Guid ChatId { get; set; }
    public Guid UserId { get; set; }
}

public class GetChatMessagesQueryHandler : IRequestHandler<GetChatMessagesQuery, List<ChatMessageDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IChatService _chatService;
    private readonly IMapper _mapper;
    private readonly IUserService _userService;

    public GetChatMessagesQueryHandler(
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

    public async Task<List<ChatMessageDto>> Handle(GetChatMessagesQuery request, CancellationToken cancellationToken)
    {
        var chatMember = await _dbContext.ChatMembers
            .SingleOrDefaultAsync(cm => cm.ChatId == request.ChatId && cm.MemberUserId == request.UserId)
            ?? throw new ForbiddenException();

        chatMember.LastSeen = DateTimeOffset.UtcNow;

        await _dbContext.SaveChangesAsync();

        var messages = await _chatService.GetChatMessagesAsync(request.ChatId);

        var memberIds = messages.Select(m => m.SenderId).Distinct();
        var contacts = new Dictionary<Guid, UserDto>();
        foreach (var memberId in memberIds)
        {
            var contact = await _userService.GetUserById(memberId);
            contacts.Add(contact.Id, _mapper.Map<UserDto>(contact));
        }

        var mappedMessages = _mapper.Map<List<ChatMessageDto>>(messages);
        mappedMessages.ForEach(d => d.Sender = contacts[d.Sender.Id]);

        return mappedMessages;
    }
}