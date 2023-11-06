using AutoMapper;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Chat;
using EventPlanr.Application.Models.User;
using EventPlanr.Domain.Constants;
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
    private readonly IUserClaimService _userClaimService;

    public GetChatMessagesQueryHandler(
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

    public async Task<List<ChatMessageDto>> Handle(GetChatMessagesQuery request, CancellationToken cancellationToken)
    {
        var chatMember = await _dbContext.ChatMembers
                .SingleOrDefaultAsync(cm => cm.ChatId == request.ChatId && cm.MemberUserId == request.UserId);

        if (chatMember == null)
        {
            var chat = await _dbContext.Chats
                .AsNoTracking()
                .Include(c => c.Event)
                .SingleEntityAsync(c => c.Id == request.ChatId);

            var userClaims = await _userClaimService.GetUserClaimAsync(request.UserId);
            var organizationPolicies = userClaims.Organizations
                .SingleOrDefault(o => o.OrganizationId == userClaims.CurrentOrganizationId);

            if (chat.Event == null || chat.Event.OrganizationId != userClaims.CurrentOrganizationId
                || organizationPolicies == null || !organizationPolicies.Policies.Contains(OrganizationPolicies.EventChat))
            {
                throw new ForbiddenException();
            }
        }

        var organization = await _dbContext.Organizations
            .AsNoTracking()
            .SingleOrDefaultAsync(o => o.Events.Any(e => e.ChatId == request.ChatId));

        var messages = await _chatService.GetChatMessagesAsync(request.ChatId);

        var memberIds = messages.Select(m => m.SenderId).Distinct();
        var contacts = new Dictionary<Guid, UserDto>();
        foreach (var memberId in memberIds)
        {
            var contact = await _userService.GetUserById(memberId);
            if (contact != null)
            {
                contacts.Add(contact.Id, _mapper.Map<UserDto>(contact));
            }
        }

        var mappedMessages = _mapper.Map<List<ChatMessageDto>>(messages);
        mappedMessages.ForEach(d =>
        {
            if (contacts.ContainsKey(d.Sender.Id))
            {
                d.Sender = contacts[d.Sender.Id];
            }
            else
            {
                d.Sender = new UserDto()
                {
                    Id = d.Sender.Id,
                    FirstName = organization!.Name,
                    LastName = "",
                    ProfileImageUrl = organization!.ProfileImageUrl,
                };
            }
        });

        return mappedMessages;
    }
}