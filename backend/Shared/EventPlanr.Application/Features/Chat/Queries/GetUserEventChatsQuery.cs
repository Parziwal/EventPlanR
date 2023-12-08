using AutoMapper;
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

        var chatIds = chats.Items.Select(c => c.Id).ToList();
        var userChatMembers = await _dbContext.ChatMembers
            .AsNoTracking()
            .Where(cm => cm.MemberUserId == _user.UserId && chatIds.Contains(cm.ChatId))
            .ToListAsync();

        chats.Items.ForEach(chat =>
        {
            var chatMember = userChatMembers.Single(cm => cm.ChatId == chat.Id);
            chat.HaveUnreadMessages = chat.LastMessageDate > chatMember.LastSeen;
        });

        return chats;
    }
}
