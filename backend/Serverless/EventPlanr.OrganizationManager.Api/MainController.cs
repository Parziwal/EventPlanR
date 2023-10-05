using EventPlanr.Application.Contracts;
using EventPlanr.Application.Features.Organization.Commands;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace EventPlanr.OrganizationManager.Api;

[ApiController]
[Route("organizationmanager")]
public class MainController : ControllerBase
{
    private readonly ISender _sender;
    private readonly IUserContext userContext;

    public MainController(ISender sender, IUserContext userContext)
    {
        _sender = sender;
        this.userContext = userContext;
    }

    [HttpGet]
    public string GetUserOrganizations()
    {
        return $"{userContext.UserId} {userContext.FirstName} {userContext.LastName} {userContext.Email}";
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
