﻿using AutoMapper;
using AutoMapper.QueryableExtensions;
using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Chat;
using EventPlanr.Application.Models.Pagination;
using EventPlanr.Application.Security;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Chat.Queries;

[Authorize]
public class GetUserEventChatsQuery : PageDto, IRequest<PaginatedListDto<EventChatDto>>
{
}

public class GetUserEventChatsQueryHandler : IRequestHandler<GetUserEventChatsQuery, PaginatedListDto<EventChatDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IMapper _mapper;

    public GetUserEventChatsQueryHandler(IApplicationDbContext dbContext, IUserContext user, IMapper mapper)
    {
        _dbContext = dbContext;
        _user = user;
        _mapper = mapper;
    }

    public async Task<PaginatedListDto<EventChatDto>> Handle(GetUserEventChatsQuery request, CancellationToken cancellationToken)
    {
        var chats = await _dbContext.Chats
            .AsNoTracking()
            .Include(c => c.ChatMembers)
            .Where(c => c.Event != null && c.Event!.IsPublished)
            .Where(c => c.ChatMembers.Any(cm => cm.MemberUserId == _user.UserId))
            .OrderByDescending(c => c.LastMessageDate)
            .ProjectTo<EventChatDto>(_mapper.ConfigurationProvider)
            .ToPaginatedListAsync(request);

        await Parallel.ForEachAsync(chats.Items, async (c, _) => {
            var chatMember = await _dbContext.ChatMembers
                .AsNoTracking()
                .SingleEntityAsync(cm => cm.MemberUserId == _user.UserId && cm.ChatId == c.Id);
            c.HaveUnreadMessages = c.LastMessageDate > chatMember.LastSeen;
        });

        return chats;
    }
}
