using EventPlanr.Application.Features.Organization.Commands;
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
    public void GetUserOrganizations()
    {

    }

    [HttpPost]
    public Task CreateOrganization([FromBody] CreateOrganizationCommand command)
        => _sender.Send(command);

    [HttpPut("{organizationId}")]
    public Task UpdateOrganization(Guid organizationId, [FromBody] UpdateOrganizationCommand command)
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
