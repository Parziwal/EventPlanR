using EventPlanr.Application.Features.NewsPost.Commands;
using EventPlanr.Application.Features.NewsPost.Queries;
using EventPlanr.Application.Models.NewsPost;
using EventPlanr.Application.Models.Pagination;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventPlanr.UserTicket.Api;

[ApiController]
[Route("newspostmanager")]
public class MainController : ControllerBase
{
    private readonly ISender _sender;

    public MainController(ISender sender)
    {
        _sender = sender;
    }

    [HttpGet("{eventId}")]
    public Task<PaginatedListDto<OrganizationNewsPostDto>> GetEventNewsPost(Guid eventId, [FromQuery] PageDto page)
        => _sender.Send(new GetOrganizationEventNewsPostQuery()
        {
            EventId = eventId,
            PageNumber = page.PageNumber,
            PageSize = page.PageSize,
        });

    [HttpPost("{eventId}")]
    public Task<Guid> CreateNewsPost(Guid eventId, [FromBody] CreateNewsPostCommand command)
    {
        command.EventId = eventId;
        return _sender.Send(command);
    }

    [HttpDelete("{newsPostId}")]
    public Task DeleteNewsPost(Guid newsPostId)
        => _sender.Send(new DeleteNewsPostCommand()
        {
            NewsPostId = newsPostId,
        });
}
