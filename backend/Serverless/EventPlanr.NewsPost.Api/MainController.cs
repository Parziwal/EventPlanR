using EventPlanr.Application.Features.NewsPost.Commands;
using EventPlanr.Application.Features.NewsPost.Queries;
using EventPlanr.Application.Models.NewsPost;
using EventPlanr.Application.Models.Pagination;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventPlanr.UserTicket.Api;

[ApiController]
[Route("newspost")]
public class MainController : ControllerBase
{
    private readonly ISender _sender;

    public MainController(ISender sender)
    {
        _sender = sender;
    }

    [HttpGet("{eventId}")]
    public Task<PaginatedListDto<NewsPostDto>> GetEventNewsPost(Guid eventId, [FromQuery] GetEventNewsPostQuery query)
    {
        query.EventId = eventId;
        return _sender.Send(query);
    }

    [HttpPost("{eventId}")]
    public Task<Guid> CreateNewsPost(Guid eventId, [FromBody] CreateNewsPostCommand command)
    {
        command.EventId = eventId;
        return _sender.Send(command);
    }

    [HttpDelete("{newsPostId}")]
    public Task CreateNewsPost(Guid newsPostId)
        => _sender.Send(new DeleteNewsPostCommand()
        {
            NewsPostId = newsPostId,
        });
}
