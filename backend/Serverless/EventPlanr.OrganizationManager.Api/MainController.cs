using EventPlanr.Application.Features.Organization.Commands;
using EventPlanr.Application.Features.Organization.Queries;
using EventPlanr.Application.Models.Organization;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventPlanr.OrganizationManager.Api;

[ApiController]
[Route("organizationmanager")]
public class MainController : ControllerBase
{
    private readonly ISender _sender;

    public MainController(ISender sender)
    {
        _sender = sender;
    }

    [HttpGet]
    public Task<List<OrganizationDto>> GetUserOrganizations()
        => _sender.Send(new GetUserOrganizationsQuery());

    [HttpGet("current")]
    public Task<OrganizationDto> GetUserCurrentOrganization()
        => _sender.Send(new GetUserCurrentOrganizationQuery());

    [HttpGet("current/details")]
    public Task<UserOrganizationDetailsDto> GetUserCurrentOrganizationDetails()
        => _sender.Send(new GetUserCurrentOrganizationDetailsQuery());


    [HttpPost("set/{organizationId}")]
    public Task SetUserOrganization(Guid organizationId)
        => _sender.Send(new SetUserOrganizationCommand()
        {
            OrganizationId = organizationId,
        });

    [HttpPost]
    public Task<Guid> CreateOrganization([FromBody] CreateOrganizationCommand command)
        => _sender.Send(command);

    [HttpPut("{organizationId}")]
    public Task EditOrganization(Guid organizationId, [FromBody] EditOrganizationCommand command)
    {
        command.OrganizationId = organizationId;
        return _sender.Send(command);
    }

    [HttpDelete("{organizationId}")]
    public Task DeleteOrganization(Guid organizationId)
        => _sender.Send(new DeleteOrganizationCommand()
        {
            OrganizationId = organizationId,
        });

    [HttpPost("member/{organizationId}")]
    public Task AddMemberToOrganization(Guid organizationId, [FromBody] AddMemberToOrganizationCommand command)
    {
        command.OrganizationId = organizationId;
        return _sender.Send(command);
    }

    [HttpDelete("member/{organizationId}")]
    public Task RemoveMemberToOrganization(Guid organizationId, [FromBody] RemoveMemberFromOrganizationCommand command)
    {
        command.OrganizationId = organizationId;
        return _sender.Send(command);
    }
}
