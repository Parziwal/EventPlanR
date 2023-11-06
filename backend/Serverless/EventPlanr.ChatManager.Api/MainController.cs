using EventPlanr.Application.Features.Chat.Commands;
using EventPlanr.Application.Features.Chat.Queries;
using EventPlanr.Application.Features.User.Commands;
using EventPlanr.Application.Models.Chat;
using EventPlanr.Application.Models.Pagination;
using EventPlanr.LambdaBase.Image;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventPlanr.ChatManager.Api;

[ApiController]
[Route("chatmanager")]
public class MainController : ControllerBase
{
    private readonly ISender _sender;

    public MainController(ISender sender)
    {
        _sender = sender;
    }

    [HttpGet("direct")]
    public Task<PaginatedListDto<DirectChatDto>> GetUserDirectChats([FromQuery] PageDto page)
        => _sender.Send(new GetUserDirectChatsQuery()
        {
            PageNumber = page.PageNumber,
            PageSize = page.PageSize,
        });

    [HttpPost("direct")]
    public Task<Guid> CreateDirectChat([FromBody] CreateDirectChatCommand command)
        => _sender.Send(command);

    [HttpGet("event")]
    public Task<PaginatedListDto<EventChatDto>> GetUserEventChats([FromQuery] PageDto page)
        => _sender.Send(new GetUserEventChatsQuery()
        {
            PageNumber = page.PageNumber,
            PageSize = page.PageSize,
        });

    [HttpPost("setread/{chatId}")]
    public Task SetChatMessagesRead(Guid chatId)
        => _sender.Send(new SetChatMessagesReadCommand()
        {
            ChatId = chatId,
        });

    [HttpPost("profileimage")]
    public async Task<string> UploadUserProfileImage([FromForm] ImageUploadDto profileImage)
    {
        using var ms = new MemoryStream();
        profileImage.ImageFile.CopyTo(ms);
        var fileBytes = ms.ToArray();

        return await _sender.Send(new UploadUserProfileImageCommand()
        {
            Image = fileBytes,
        });
    }
}
