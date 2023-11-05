using EventPlanr.Application.Features.Chat.Commands;
using EventPlanr.Application.Features.Chat.Queries;
using EventPlanr.Application.Models.Chat;
using EventPlanr.Application.Models.Pagination;
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
}
