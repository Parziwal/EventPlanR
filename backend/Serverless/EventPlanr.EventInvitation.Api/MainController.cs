using EventPlanr.Application.Features.Invitation.Commands;
using EventPlanr.Application.Features.Invitation.Queries;
using EventPlanr.Application.Models.Invitation;
using EventPlanr.Application.Models.Pagination;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventPlanr.EventInvitation.Api;

[ApiController]
[Route("eventinvitation")]
public class MainController : ControllerBase
{
    private readonly ISender _sender;

    public MainController(ISender sender)
    {
        _sender = sender;
    }

    [HttpGet("organizationevent")]
    public Task<PaginatedListDto<EventInvitationDto>> GetOrganizationEventInvitations([FromQuery] GetOrganizationEventInvitationsQuery query)
        => _sender.Send(query);

    [HttpGet("userevent/{eventId}")]
    public Task<UserInvitationDto> GetUserEventInvitation(Guid eventId)
        => _sender.Send(new GetUserEventInvitationQuery()
        {
            EventId = eventId,
        });

    [HttpPost("organizationevent")]
    public Task InviteUserToEvent(InviteUserToEventCommand command)
        => _sender.Send(command);

    [HttpDelete("organizationevent")]
    public Task DeleteUserInvitation(DeleteInvitationCommand command)
        => _sender.Send(command);

    [HttpPost("userevent/status")]
    public Task AcceptOrDenyInvitation(AcceptOrDenyInvitationCommand command)
        => _sender.Send(command);
}
