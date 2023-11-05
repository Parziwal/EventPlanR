﻿using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Chat;
using EventPlanr.Application.Models.User;
using EventPlanr.Domain.Constants;
using EventPlanr.Domain.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;

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
    private readonly IUserClaimService _userClaimService;

    public CreateChatMessageCommandHandler(
        IApplicationDbContext dbContext,
        IChatService chatService,
        IMapper mapper,
        IUserService userService,
        IUserClaimService userClaimService)
    {
        _dbContext = dbContext;
        _chatService = chatService;
        _mapper = mapper;
        _userService = userService;
        _userClaimService = userClaimService;
    }

    public async Task<ChatMessageDto> Handle(CreateChatMessageCommand request, CancellationToken cancellationToken)
    {
        var chat = await _dbContext.Chats
            .SingleEntityAsync(c => c.Id == request.ChatId);
        var chatMember = await _dbContext.ChatMembers
            .SingleOrDefaultAsync(cm => cm.ChatId == request.ChatId && cm.MemberUserId == request.UserId);

        var userClaims = await _userClaimService.GetUserClaimAsync(request.UserId);
        var organizationPolicies = userClaims.Organizations
            .SingleOrDefault(o => o.OrganizationId == userClaims.CurrentOrganizationId);

        if (chatMember == null &&
            (chat.Event == null || chat.Event.OrganizationId != userClaims.CurrentOrganizationId
                || organizationPolicies == null || !organizationPolicies.Policies.Contains(OrganizationPolicies.EventChat)))
        {
            throw new ForbiddenException();
        }

        var timeNow = DateTimeOffset.UtcNow;
        var message = new ChatMessageEntity()
        { 
            ChatId = request.ChatId,
            Content = request.Content,
            CreatedAt = timeNow,
            SenderId = userClaims.CurrentOrganizationId ?? request.UserId,
        };

        await _chatService.AddMessageToChat(message);

        chat.LastMessageDate = timeNow;

        await _dbContext.SaveChangesAsync();

        var mappedMessage = _mapper.Map<ChatMessageDto>(message);
        var sender = await _userService.GetUserById(mappedMessage.Sender.Id);
        mappedMessage.Sender = _mapper.Map<UserDto>(sender);
        return mappedMessage;
    }
}