using EventPlanr.Application.Features.Event.Commands;
using EventPlanr.Application.Features.Event.Queries;
using EventPlanr.Application.Models.Event;
using EventPlanr.Application.Models.Pagination;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventPlanr.EventManager.Api;

[ApiController]
[Route("eventmanager")]
public class MainController : ControllerBase
{
    private readonly ISender _sender;

    public MainController(ISender sender)
    {
        _sender = sender;
    }

    [HttpGet("draft")]
    public Task<PaginatedListDto<OrganizationEventDto>> GetOrganizationDraftEvents([FromQuery] GetOrganizationDraftEventsQuery query)
        => _sender.Send(query);

    [HttpGet("past")]
    public Task<PaginatedListDto<OrganizationEventDto>> GetOrganizationPastEvents([FromQuery] GetOrganizationPastEventsQuery query)
        => _sender.Send(query);
    
    [HttpGet("upcoming")]
    public Task<PaginatedListDto<OrganizationEventDto>> GetOrganizationUpcomingEvents([FromQuery] GetOrganizationUpcomingEventsQuery query)
        => _sender.Send(query);

    [HttpGet("{eventId}")]
    public Task<OrganizationEventDetailsDto> GetOrganizationEventDetails(Guid eventId)
        => _sender.Send(new GetOrganizationEventDetailsQuery()
        {
            EventId = eventId,
        });

    [HttpPost]
    public Task<Guid> CreateEvent([FromBody] CreateEventCommand command)
        => _sender.Send(command);


    [HttpPut("{eventId}")]
    public Task EditEvent(Guid eventId, [FromBody] EditEventCommand command)
    {
        command.EventId = eventId;
        return _sender.Send(command);
    }

    [HttpDelete("{eventId}")]
    public Task DeleteEvent(Guid eventId)
        => _sender.Send(new DeleteEventCommand()
        {
            EventId = eventId,
        });
}
