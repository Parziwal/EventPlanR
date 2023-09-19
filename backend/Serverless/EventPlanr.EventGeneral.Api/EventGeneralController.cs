using EventPlanr.Application.Features.Event.Queries;
using EventPlanr.Application.Features.Organization.Queries;
using EventPlanr.Application.Features.Ticket.Queries;
using EventPlanr.Application.Models.Event;
using EventPlanr.Application.Models.Organization;
using EventPlanr.Application.Models.Pagination;
using EventPlanr.Application.Models.Ticket;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventPlanr.EventGeneral.Api;

[Route("[controller]")]
[ApiController]
public class EventGeneralController : ControllerBase
{
    private readonly ISender _sender;

    public EventGeneralController(ISender sender)
    {
        _sender = sender;
    }

    [HttpGet]
    public Task<PaginatedListDto<EventDto>> GetFilteredEvents([FromQuery] GetFilteredEventsQuery query)
        => _sender.Send(query);

    [HttpGet("/{eventId}")]
    public Task<EventDetailsDto> GetEventDetails(Guid eventId)
        => _sender.Send(new GetEventDetailsQuery()
        {
            EventId = eventId,
        });

    [HttpGet("/ticket/{eventId}")]
    public Task<List<TicketDto>> GetEventTickets(Guid eventId)
    => _sender.Send(new GetEventTicketsQuery()
    {
        EventId = eventId,
    });

    [HttpGet("/organization")]
    public Task<PaginatedListDto<OrganizationDto>> GetOrganizations([FromQuery] GetFilteredOrganizationsQuery query)
        => _sender.Send(query);

    [HttpGet("/organization/{organizationId}")]
    public Task<OrganizationDetailsDto> GetOrganizationDetails(Guid organizationId)
        => _sender.Send(new GetOrganizationDetailsQuery()
        {
            OrganizationId = organizationId,
        });
}
