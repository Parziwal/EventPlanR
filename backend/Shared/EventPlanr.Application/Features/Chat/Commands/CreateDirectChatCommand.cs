﻿using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Resources;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Entities;
using EventPlanr.Domain.Repository;
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
    private readonly ITimeRepository _timeRepository;

    public CreateDirectChatCommandHandler(
        IApplicationDbContext dbContext,
        IUserService userService,
        IUserContext user,
        ITimeRepository timeRepository)
    {
        _dbContext = dbContext;
        _userService = userService;
        _user = user;
        _timeRepository = timeRepository;
    }

    public async Task<Guid> Handle(CreateDirectChatCommand request, CancellationToken cancellationToken)
    {
        var contactUserId = await _userService.GetUserIdByEmail(request.UserEmail)
            ?? throw new EntityNotFoundException("UserEntity_NotFound");

        var chatExists = await _dbContext.Chats
            .Where(c => c.Event == null)
            .SingleOrDefaultAsync(c => c.ChatMembers.Any(cm => cm.MemberUserId == _user.UserId)
                && c.ChatMembers.Any(cm => cm.MemberUserId == contactUserId));

        if (chatExists != null)
        {
            throw new DomainException("ChatAlreadyExists");
        }

        var timeNow = _timeRepository.GetCurrentUtcTime();
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