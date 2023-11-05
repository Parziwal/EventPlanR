using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Models.Chat;
using EventPlanr.Application.Models.Pagination;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Features.Chat.Queries;

[Authorize]
public class GetUserDirectChatsQuery : PageDto, IRequest<PaginatedListDto<DirectChatDto>>
{
}

public class GetUserDirectChatsQueryHandler : IRequestHandler<GetUserDirectChatsQuery, PaginatedListDto<DirectChatDto>>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IUserService _userService;

    public GetUserDirectChatsQueryHandler(IApplicationDbContext dbContext, IUserContext user, IUserService userService)
    {
        _dbContext = dbContext;
        _user = user;
        _userService = userService;
    }

    public async Task<PaginatedListDto<DirectChatDto>> Handle(GetUserDirectChatsQuery request, CancellationToken cancellationToken)
    {
        var chats = await _dbContext.Chats
            .AsNoTracking()
            .Include(c => c.ChatMembers)
            .Where(c => c.Event == null)
            .Where(c => c.ChatMembers.Any(cm => cm.MemberUserId == _user.UserId))
            .OrderByDescending(c => c.LastMessageDate)
            .ToPaginatedListAsync(request);

        var contacts = new List<UserEntity>();
        foreach (var chat in chats.Items) {
            var contactUserId = chat.ChatMembers
                .Single(cm => cm.MemberUserId != _user.UserId)
                .MemberUserId;
            var contact = await _userService.GetUserById(contactUserId);
            contacts.Add(contact);
        }

        return new PaginatedListDto<DirectChatDto>
        {
            Items = chats.Items.Select(c =>
            {
                var contactUserId = c.ChatMembers
                    .Single(cm => cm.MemberUserId != _user.UserId)
                    .MemberUserId;
                var contact = contacts.Single(c => c.Id == contactUserId);

                var currentUser = c.ChatMembers
                    .Single(cm => cm.MemberUserId == _user.UserId);
                return new DirectChatDto()
                {
                    Id = c.Id,
                    LastMessageDate = c.LastMessageDate,
                    HaveUnreadMessages = c.LastMessageDate > currentUser.LastSeen,
                    ContactFirstName = contact.FirstName,
                    ContactLastName = contact.LastName,
                    ProfileImageUrl = null,
                };
            }).ToList(),
            PageNumber = chats.PageNumber,
            TotalCount = chats.TotalCount,
            TotalPages = chats.TotalPages,
        };
    }
}
