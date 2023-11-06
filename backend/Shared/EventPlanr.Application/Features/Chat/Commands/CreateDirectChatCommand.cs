﻿using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Chat.Commands;

[Authorize]
public class CreateDirectChatCommand : IRequest<Guid>
{
    public string UserEmail { get; set; } = null!;
}

public class CreateDirectChatCommandHandler : IRequestHandler<CreateDirectChatCommand, Guid>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserService _userService;
    private readonly IUserContext _user;

    public CreateDirectChatCommandHandler(IApplicationDbContext dbContext, IUserService userService, IUserContext user)
    {
        _dbContext = dbContext;
        _userService = userService;
        _user = user;
    }

    public async Task<Guid> Handle(CreateDirectChatCommand request, CancellationToken cancellationToken)
    {
        var contactUserId = await _userService.GetUserIdByEmail(request.UserEmail)
            ?? throw new EntityNotFoundException();

        var chatExists = await _dbContext.Chats
            .Where(c => c.Event == null)
            .SingleOrDefaultAsync(c => c.ChatMembers.Any(cm => cm.MemberUserId == _user.UserId)
                && c.ChatMembers.Any(cm => cm.MemberUserId == contactUserId));

        if (chatExists != null)
        {
            throw new DomainException();
        }

        var timeNow = DateTimeOffset.UtcNow;
        var chat = new ChatEntity()
        {
            LastMessageDate = timeNow,
            ChatMembers = new List<ChatMemberEntity> { 
                new ChatMemberEntity()
                { 
                    MemberUserId = _user.UserId,
                    LastSeen = timeNow,
                },
                new ChatMemberEntity()
                {
                    MemberUserId = contactUserId,
                    LastSeen = timeNow,
                }
            },
        };

        _dbContext.Chats.Add(chat);

        await _dbContext.SaveChangesAsync();

        return chat.Id;
    }
}